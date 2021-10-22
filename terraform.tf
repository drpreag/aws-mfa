# basic terraform project settings

provider "aws" {
  region  = "eu-west-1"   # CHANGE
  profile = "default"     # CHANGE
}

terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.62"
    }
  }
  backend "s3" {
    bucket = "<aws_account_id>-terraform-state" # CHANGE
    region = "eu-west-1"                        # CHANGE
    key    = "aws_mfa-<aws_account_id>.tfstate" # CHANGE
  }
}

