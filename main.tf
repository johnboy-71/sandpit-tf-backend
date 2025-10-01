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

data "aws_ami" "test_latest_windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

resource "aws_instance" "my_ec2_server" {
  ami           = data.aws_ami.test_latest_windows.id
  instance_type = "t2.small" # Specify an instance type
  subnet_id     = "subnet-044071109ad3de8ea"



  tags = {
    Name  = devwinserver01
    Owner = "J_Fagan"
  }
}

# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#   name = ""

#   instance_type = "t3.micro"
#   key_name      = "user1"
#   monitoring    = true
#   subnet_id     = "subnet-eddcdzz4"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }