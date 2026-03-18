module "sns" {
  source = "./local_modules/notification"
  env_name = var.env_name
}