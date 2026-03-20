module "metric_filter" {
  source   = "./local_modules/monitoring"
  env_name = var.env_name
  sns_topic_arn = module.sns.sns_topic_arn
}