

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn_distribution.domain_name
}




output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn_distribution.id
}

/*

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.website.id 
}

*/