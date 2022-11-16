data "aws_availability_zones" "available_azs" {
  state = "available"
}

resource "aws_instance" "dev_instance" {
  ami           = "${lookup(var.ami, var.AWS_REGION)}"
  #instance_type = "t2.micro"
  instance_type = var.instance_types[0]
  #subnet
  subnet_id   = aws_subnet.sample_public_subnet.id
  #security group
  vpc_security_group_ids = ["${aws_security_group.sg_allow_ssh.id}"]
  #key pair
  key_name = aws_key_pair.ec2_ssh_public_key.id
  #iam instance profile
  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name

  connection {
    user = "ec2-user"
    host = self.public_ip
    private_key = "${file(var.private_key)}"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo amazon-linux-extras install nginx1 -y",
        "sudo service nginx start",
    ]
  }

  tags = {
    Name = "dev_instance"
  }
}

resource "aws_key_pair" "ec2_ssh_public_key" {
    key_name = "id_github_rsa"
    public_key = "${file(var.public_key)}"
}

output "ec2_instance_id" {
  value = aws_instance.dev_instance.id
}

output "ec2_instance_az" {
  value = aws_instance.dev_instance.availability_zone
}

output "available_azs_list" {
  value = data.aws_availability_zones.available_azs[*].names
}