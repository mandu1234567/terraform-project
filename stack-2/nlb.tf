module "nlb" {
  source = "./local_modules/loadbalancing"
  env_name = var.env_name
  vpc_id = module.project_networking.vpc_id
  private_subnet_ids = module.project_networking.private_subnet_ids
  vpc_cidr = var.vpc_cidr
  public_subnet_ids = module.project_networking.public_subnet_ids
}