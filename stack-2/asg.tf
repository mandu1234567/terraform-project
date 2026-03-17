module "asg" {
  source = "./local_modules/asg"
  env_name = var.env_name
  vpc_id   = module.project_networking.vpc_id
  vpc_cidr = var.vpc_cidr
  jar_file_name   = var.jar_file_name
  instance_type           = var.instance_type
  private_subnet_id       = module.project_networking.private_subnet_ids
  rds_db_parameter_name  = var.rds_db_parameter_name
  rds_db_username        = var.rds_db_username
  rds_db_endpoint = module.storage.rds_db_endpoint


}