variable "env_name" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be created"
  type        = string
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs for the load balancer"
  type        = list(string)
}
variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
  
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}