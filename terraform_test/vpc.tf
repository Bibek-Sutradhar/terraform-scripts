resource "aws_vpc" "vpc_test_1" {
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"
  tags = {
    Name = "Test VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_test_1.id
  cidr_block = "10.0.0.0/25"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Public subnet"
  }
}

/*resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_test_1.id
  cidr_block = "10.0.0.0/25"

  tags = {
    Name = "Private subnet"
  }
}*/

