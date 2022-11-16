#Application Load Balancer
resource "aws_lb" "external_alb" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  tags = {
    name = "external ALB"
  }
}

#Target group
resource "aws_lb_target_group" "external_alb_target_group" {
  name     = "external-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id
}

#Target group attachment
resource "aws_lb_target_group_attachment" "external_alb_ec2_1_attachment" {
  target_group_arn = aws_lb_target_group.external_alb_target_group.arn
  target_id        = aws_instance.ec2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "external_alb_ec2_2_attachment" {
  target_group_arn = aws_lb_target_group.external_alb_target_group.arn
  target_id        = aws_instance.ec2_2.id
  port             = 80
}

#ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_alb_target_group.arn
  }
}