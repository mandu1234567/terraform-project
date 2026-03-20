module "acm" {
  source = "./local_modules/acm"

  domain_name = var.domain_name
  alt_names   = ["${var.domain_name}"]
  zone_id     = var.hosted_zone_id
}