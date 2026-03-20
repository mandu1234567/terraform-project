
terraform {
  backend "s3" {
    bucket       = "mandu-terraform-state-bucket"
    key          = "env/test/terraform.tfstate"
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