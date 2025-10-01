terraform {
  required_version = ">1.8.0"

  backend "s3" {
    encrypt = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
  }
}

provider "aws" {
  region              = var.aws.region
  allowed_account_ids = var.aws_account_id
}