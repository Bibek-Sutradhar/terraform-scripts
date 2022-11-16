resource "aws_instance" "ec2_1" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az1
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  key_name = aws_key_pair.ec2_key_pair.id
  associate_public_ip_address = "true"
  user_data              = <<EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    EOF

  tags = {
    name = "ec2_1"
  }
}

resource "aws_instance" "ec2_2" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = var.az2
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  key_name = aws_key_pair.ec2_key_pair.id
  associate_public_ip_address = "true"
  user_data              = <<EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    EOF

  tags = {
    name = "ec2_2"
  }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "ec2_instance_keypair"
  public_key = "${file("~/.ssh/ec2_instance_keypair.pub")}"
}