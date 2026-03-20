module "route" {
  source = "./local_modules/route_53"

  hosted_zone_id = var.hosted_zone_id
  domain_name = var.domain_name

  cf_domain_name    = module.cloudfront.domain_name
  cf_hosted_zone_id = module.cloudfront.hosted_zone_id
}