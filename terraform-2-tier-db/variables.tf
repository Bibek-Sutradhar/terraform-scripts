variable "AWS_REGION" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet1" {
  default = "10.0.1.0/24"
}

variable "public_subnet2" {
  default = "10.0.2.0/24"
}

variable "private_subnet1" {
  default = "10.0.3.0/24"
}

variable "private_subnet2" {
  default = "10.0.4.0/24"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "ec2_ami" {
  default = "ami-09d3b3274b6c5d4aa"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}