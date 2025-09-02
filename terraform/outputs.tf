
resource "local_file" "inventory_file" {
  content =  templatefile("./inventory.template",
  {

    ec2_public_dns  = module.ec2.public_dns
  #  monitring_ec2_public_dns = module.ec2.public_dns
    region = var.instance_config.region
    backend_ecr_uri = module.ecr.backend_ecr_uri
    environment = var.environment
    role_arn = module.iam.ec2_role_arn
    backend_ecr_repository_name = module.ecr.backend_ecr_repository_name
    aws_account_id = module.ecr.aws_account_id
    frontend_bucket_name = module.website.bucket_name
  cloudfront_distribution_id = module.cloudfront_distribution.cloudfront_distribution_id
  })
   filename = "../ansible/inventory"  
}



output "instance_ids" {
  description = "EC2 instance IDs"
  value       = module.ec2.instance_ids
}

output "public_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.ec2.public_ips
}

output "private_ips" {
  description = "Private IPs of EC2 instances"
  value       = module.ec2.private_ips
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.ec2.security_group_id
}


output "cloudfront_domain" {
  value = module.cloudfront_distribution.cloudfront_domain_name
}

output "s3_bucket_name" {
  value = module.website.bucket_name
}

output "alb_dns" {
  value = module.alb.alb_dns_name
}
