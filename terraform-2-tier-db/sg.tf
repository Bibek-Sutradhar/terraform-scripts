#custom vpc security group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow inbound HTTP traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_sg"
  }
}

#webserver security group
resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "Allow inbound HTTP traffic from ALB"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    description = "HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [aws_security_group.web_sg.id]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description = "SSH from ALB"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.web_sg.id]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "webserver_sg"
  }
}

#database security group
resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "Database security group"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [aws_security_group.webserver_sg.id]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "database_sg"
  }
}