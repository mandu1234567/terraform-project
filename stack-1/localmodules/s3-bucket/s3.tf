resource "aws_s3_bucket" "bucket_fe" {
  bucket = "mandu-${var.bucket_name}-fe-bucket"
}

resource "aws_s3_bucket" "bucket_be" {
  bucket = "mandu-${var.bucket_name}-be-bucket"
}