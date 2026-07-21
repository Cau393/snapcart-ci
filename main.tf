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
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3 = "http://host.docker.internal:4566"
    dynamodb = "http://host.docker.internal:4566"
  }
}

variable "project_name" {
  description = "Base name used for all SnapCart resources"
  type        = string
  default     = "snapcart"
}

resource "aws_s3_bucket" "images" {
  bucket = "${var.project_name}-product-images"
}

resource "aws_dynamodb_table" "products" {
  name         = "${var.project_name}-products"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.images.bucket
}

output "table_name" {
  value = aws_dynamodb_table.products.name
}
