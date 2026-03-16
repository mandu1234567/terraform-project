module "asg" {
  source = "./local_modules/asg"

  env_name = var.env_name
}