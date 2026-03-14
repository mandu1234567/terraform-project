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