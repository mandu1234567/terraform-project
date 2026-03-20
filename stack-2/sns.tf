module "sns" {
  source = "./local_modules/notification"
  env_name = var.env_name
  lambda_function_arn = module.lambda.lambda_function_arn
}