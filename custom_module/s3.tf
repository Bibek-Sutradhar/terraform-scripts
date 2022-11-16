resource "aws_s3_bucket" "dev_bucket" {
  bucket = "dev-s3-bkt-03112022"

  tags = {
    Name        = "dev-s3-bkt-03112022"
    Environment = "Dev"
  }
}