output "vpc_id" {
  description = "ID of the VPC"
  value       = module.project_networking.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.project_networking.vpc_cidr
}

output "public_subnet_id" {
  description = "IDs of the public subnets"
  value       = module.project_networking.public_subnet_ids
}

output "private_subnet_id" {
  description = "IDs of the private subnets"
  value       = module.project_networking.private_subnet_ids
}