output "dev_instance_id" {
  value = aws_instance.dev_instance.id
}

output "dev_instance_public_ip" {
  value = aws_instance.dev_instance.public_ip
}