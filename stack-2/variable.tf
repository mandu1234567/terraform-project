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
variable "slack_web_hook_url" {
  type        = string
  description = "Slack webhook url."
}
variable "origin_id" {
  type        = string
  description = "Origin id"
}
variable "default_behavior_allowed_methods" {
  type        = list(string)
  description = "Default behaviour allow methods"
}
variable "default_behavior_cached_methods" {
  type        = list(string)
  description = "Default behaviour cached methods"
}
variable "default_behavior_forwarded_values_header" {
  type        = list(string)
  description = "Default behaviour forwarded value headers"
}
variable "domain_name" {
  type = string
}
variable "hosted_zone_id" {
  type = string
}