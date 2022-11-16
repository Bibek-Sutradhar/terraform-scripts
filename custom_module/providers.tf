terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "dev-s3-bkt-03112022"
    key    = "statefile/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.AWS_REGION
}

resource "aws_iam_user" "terraform_user" {
  name = "terraform_user"
  #path = "/system/"

  tags = {
    tag-key = "terraform_user"
  }
}

resource "aws_iam_access_key" "user_access_key" {
  user = aws_iam_user.terraform_user.name
}

output "user_unique_id" {
  value = aws_iam_user.terraform_user.unique_id
}

output "user_access_key" {
  sensitive = true
  value = aws_iam_access_key.user_access_key.*
}


