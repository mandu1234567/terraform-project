variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}
variable "vpc_name" {
    description = "Name tag for the VPC"
    type        = string
}
variable "public_subnet_cidr" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}
variable "private_subnet_cidr" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}
variable "azs" {
  description = "Availability zones for subnets"
  type        = list(string)
}