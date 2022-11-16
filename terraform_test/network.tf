#create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_test_1.id

  tags = {
    Name = "Internet Gateway"
  }
}
#create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_test_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "example"
  }
}
#create security group
resource "aws_security_group" "ec2_ssh_sg" {
  name        = "allow_ssh"
  #description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_test_1.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  /*egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }*/

  tags = {
    Name = "allow_ssh"
  }
}
#Associate Rout Table with subnet
resource "aws_route_table_association" "rt_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}