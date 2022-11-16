#create a VPC
resource "aws_vpc" "sample_vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "sample_vpc"
  }
}

#create a Public subnet
resource "aws_subnet" "sample_public_subnet" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = "10.0.0.0/25"
  map_public_ip_on_launch = "true"
  #availability_zone = ""

  tags = {
    Name = "sample public subnet"
  }
}

data "aws_vpc" "default_vpc" {
  filter {
    name = "tag:Name"
    values = ["default"]
  }
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}