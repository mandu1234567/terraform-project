resource "aws_route53_record" "cf_root" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cf_domain_name   
    zone_id                = var.cf_hosted_zone_id
    evaluate_target_health = false
  }
}

