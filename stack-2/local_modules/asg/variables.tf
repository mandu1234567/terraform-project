variable "env_name" {
  description = "Environment name"
  type        = string
}
variable "vpc_id" {
  type        = string
  description = "VPC Id"
}
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}
variable "instance_type" {
  type        = string
  description = "Instance type for the launch template"
}
variable "private_subnet_id" {
  type        = list(string)
  description = "Private_Subnet Id"
}
variable "rds_db_parameter_name" {
  type        = string
  description = "SSM parameter name for RDS DB password"
}
variable "jar_file_name" {
  type        = string
  description = "Name of the JAR file to be used in the application"
}
variable "rds_db_username" {
  type        = string
  description = "RDS database username"
} 
variable "rds_db_endpoint" {
  type        = string
  description = "RDS database instance endpoint"
}
