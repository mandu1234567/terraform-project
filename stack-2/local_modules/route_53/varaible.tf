variable "hosted_zone_id" {
  description = "Hosted zone ID for the domain"
  type        = string
}
variable "domain_name" {
  description = "Domain name for the Route 53 record"
  type        = string
}
variable "cf_domain_name" {
  description = "CloudFront distribution domain name for the Route 53 alias record"
  type        = string
}
variable "cf_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID for the Route 53 alias record"
  type        = string
}