module "project_s3_buckets" {
  source      = "./localmodules/s3-bucket"
  bucket_name = var.bucket_name
}