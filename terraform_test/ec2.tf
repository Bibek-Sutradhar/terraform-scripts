resource "aws_instance" "public_ec2_instance" {
  ami           = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  #vpc_id     = aws_vpc.vpc_test_1.id
  subnet_id = aws_subnet.public_subnet.id
  key_name = aws_key_pair.ec2_instance_keypair.id
  vpc_security_group_ids = ["${aws_security_group.ec2_ssh_sg.id}"]

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_key_pair" "ec2_instance_keypair" {
  key_name   = "dec2_instance_keypair"
  public_key = "${file("~/.ssh/ec2_instance_keypair.pub")}"
}

output "ec2_instance_public_ip" {
  value = aws_instance.public_ec2_instance.public_ip
}