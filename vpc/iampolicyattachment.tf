resource "aws_iam_policy_attachment" "iam_policy_attach" {
  name       = "iam_policy_attach"
  roles      = [aws_iam_role.ec2_iam_role_dev.name]
  policy_arn = aws_iam_policy.ec2_iam_policy_dev.arn
}