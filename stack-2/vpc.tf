module "project_networking" {
    source = "./local_modules/networking"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    azs = var.azs
}