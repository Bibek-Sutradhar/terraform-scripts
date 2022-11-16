#custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  #instance_tenancy = "default"

  tags = {
    Name = "custom_vpc"
  }
}

#Public subnet 1
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet1
  availability_zone = var.az1

  tags = {
    Name = "public_subnet1"
  }
}

#Public subnet 2
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet2
  availability_zone = var.az2

  tags = {
    Name = "public_subnet2"
  }
}

#Private subnet 1
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet1
  availability_zone = var.az1

  tags = {
    Name = "private_subnet1"
  }
}

#Private subnet 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet2
  availability_zone = var.az2

  tags = {
    Name = "private_subnet2"
  }
}

data "aws_route_table" "default_rt" {

  filter {
    name   = "vpc-id"
    values = ["vpc-2e5f3e53"]
  }
}

output "default_rt" {
  value = data.aws_route_table.default_rt.route_table_id
}
#Associate default route table with the subnets
resource "aws_route_table_association" "rt_public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_route_table_association" "rt_public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_route_table_association" "rt_private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.custom_route_table.id
}

resource "aws_route_table_association" "rt_private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.custom_route_table.id
}

#create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "igw"
  }
}

#create route table
resource "aws_route_table" "custom_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "custom route table"
  }
}