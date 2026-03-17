variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}
variable "vpc_name" {
    description = "Name tag for the VPC"
    type        = string
}
variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}
variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}
variable "env_name" {
  description = "Environment name"
  type        = string
}
variable "rds_db_username" {
  description = "Username for the RDS database"
  type        = string
}
variable "rds_db_parameter_name" {
  description = "Name of the SSM parameter that contains the RDS database password"
  type        = string
}
variable "instance_type" {
  description = "Instance type for the launch template"
  type        = string
}
variable "jar_file_name" {
  description = "Name of the JAR file to be used in the application"
  type        = string
}