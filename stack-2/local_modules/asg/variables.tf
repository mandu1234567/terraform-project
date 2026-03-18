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
variable "nlb_tg_arn" {
  type        = string
  description = "ARN of the NLB target group"
} 
variable "desired_capacity" {
  type        = number
  description = "Desired capacity of the Auto Scaling Group"
}
variable "max_size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
}
variable "min_size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
}