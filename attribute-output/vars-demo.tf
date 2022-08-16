/*resource "aws_security_group" "vardemo" {
  name        = "eipaccess"

  ingress {
    description      = "var demo 1"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
    #cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "var demo 2"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
    #cidr_blocks      = [aws_eip.lb.public_ip/32]
  }

  ingress {
    description      = "var demo 3"
    from_port        = 8888
    to_port          = 8888
    protocol         = "tcp"
    cidr_blocks      = [var.vpn_ip]
    #cidr_blocks      = [aws_eip.lb.public_ip/32]
  }
}
*/
data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "myec2" {
  #ami = "ami-0cff7528ff583bf9a"
  ami = data.aws_ami.amazon_ami.id
  #instance_type = var.instance_type["us-east-1"]
  instance_type = var.instance_list[0]
  key_name = "terraform"

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./terraform.pem")}"
    }
  }
}
