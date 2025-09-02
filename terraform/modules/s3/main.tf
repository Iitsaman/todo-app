provider "aws" {
  region = "us-east-1" # CloudFront requires certs in this region
}


# 1. Create S3 bucket

resource "aws_s3_bucket" "s3_bucket" {
  bucket =  var.bucket_name 

    tags = {
    Environment = var.environment
    
  }
  
}
# my-s3-tf19-bucket"

# 2. Block all public access

resource "aws_s3_bucket_public_access_block" "public_access"  {
    bucket =  aws_s3_bucket.s3_bucket.id
     block_public_acls       = true
     block_public_policy     = true
     ignore_public_acls      = true
     restrict_public_buckets = true

}

# 3. Enable versioning

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 4. CloudFront OAI

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for S3 bucket ${var.bucket_name}"
}

# 5. S3 bucket policy to allow OAI access

resource "aws_s3_bucket_policy" "s3_oai_policy" {
   bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontAccess"
        Effect    = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_bucket.arn}/*"
#  depends_on = [aws_s3_bucket_public_access_block.public_access]
# This ensures the policy is only created after public access is fully blocked.
      }
    ]
  })


}