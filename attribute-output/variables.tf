variable "vpn_ip" {
  default = "116.50.30.20/32"
}

variable "instance_type" {
  type = map(any)
  default = {
    us-east-1  = "t2.micro"
    us-east-2  = "t2.nano"
    ap-south-1 = "t2.small"
  }
}

variable "instance_list" {
  type    = list(any)
  default = ["t2.micro", "t2.nano", "t2.small"]
}

variable "sg_ports" {
  type = list(number)
  default=[8200,8300,8400]
}
