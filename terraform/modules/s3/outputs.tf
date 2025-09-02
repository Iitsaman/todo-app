
output "bucket_name" {
    description = "Name of the S3 bucket"
  value = aws_s3_bucket.s3_bucket.bucket
}

output "origin_access_identity_path" {
   description = "CloudFront origin access identity path for use in s3_origin_config"
  value = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
}

output "bucket_domain_name" {
  description = "Regional domain name of the S3 bucket for use as CloudFront origin"
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}
