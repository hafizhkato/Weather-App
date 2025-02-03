terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}







