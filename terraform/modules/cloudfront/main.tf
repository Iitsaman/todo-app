
# CloudFront Distribution
resource "aws_cloudfront_distribution" "cdn_distribution" {
origin {
  domain_name =  var.cloudfront_config.bucket_domain_name
  origin_id  =  "s3-${var.cloudfront_config.bucket_name}"

  s3_origin_config {
   origin_access_identity = var.cloudfront_config.origin_access_identity_path

  }
}

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront for ${var.cloudfront_config.bucket_name}"
  default_root_object = "index.html"
#  aliases = [ "dev.devhelp.site" ]
  aliases     = [var.cloudfront_config.custom_domain]
  price_class = var.cloudfront_config.price_class

 default_cache_behavior {
    allowed_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]

    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${var.cloudfront_config.bucket_name}"

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
    compress = true


    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
   # cloudfront_default_certificate = true
    # Use this block instead for a custom certificate:
    acm_certificate_arn = var.cloudfront_config.acm_certificate_arn
     ssl_support_method   = "sni-only"
     minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

