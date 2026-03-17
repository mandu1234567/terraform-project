terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "mandu-terraform-state-bucket"
    key          = "env/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::248928953024:role/terraform"
    session_name = "terraform-session"
  }
}