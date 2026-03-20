module "storage" {
  source = "./local_modules/storage"

  private_subnet_ids = module.project_networking.private_subnet_ids
  vpc_id             = module.project_networking.vpc_id
  vpc_cidr           = module.project_networking.vpc_cidr

  rds_db_username        = var.rds_db_username
  rds_db_parameter_name  = var.rds_db_parameter_name
  env_name               = var.env_name
}