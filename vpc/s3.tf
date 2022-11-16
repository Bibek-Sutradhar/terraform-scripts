resource "aws_s3_bucket" "s3_bucket" {
  bucket = "dev-s3-bkt-03112022"

  tags = {
    Name        = "Dev bucket"
    Environment = "Dev"
  }
}

output "s3_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}