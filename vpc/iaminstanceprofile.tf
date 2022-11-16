resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "iam_instance_profile"
  role = aws_iam_role.ec2_iam_role_dev.name
}