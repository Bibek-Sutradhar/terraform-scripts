resource "aws_iam_policy" "ec2_iam_policy_dev" {
  name        = "ec2_iam_policy_dev"
  path        = "/"
  description = "My ec2 IAM policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:List*",
        ]
        Effect   = "Allow"
        Resource = [
            "*"
        ]
      },
    ]
  })

  tags = {
    tag-key = "ec2_iam_policy_dev"
  }
}