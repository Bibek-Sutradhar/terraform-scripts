#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "Sample IGW"
  }
}

#create route tables
resource "aws_route_table" "sample_route_table" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Sample Route Table"
  }
}

#associate route table and subnet
resource "aws_route_table_association" "rt_subnet_assoc" {
  subnet_id      = aws_subnet.sample_public_subnet.id
  route_table_id = aws_route_table.sample_route_table.id
}

#create security group
resource "aws_security_group" "sg_allow_ssh" {
  name        = "sg_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.sample_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
