terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  # Skip checks that only make sense against real AWS
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  # Send all AWS requests to LocalStack
  endpoints {
    s3 = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "images" {
  bucket = "snapcart-images"
}

output "bucket_name" {
  value = aws_s3_bucket.images.bucket
}