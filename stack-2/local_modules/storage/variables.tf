variable "env_name" {
    type = string
    description = "Environment name"
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
  description = "vpc_id"
}
variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
 }
variable "rds_db_username" {
  type = string
  description = "Username for the RDS database"
}
variable "rds_db_parameter_name" {
  type = string
  description = "Name of the SSM parameter that contains the RDS database password"
}
