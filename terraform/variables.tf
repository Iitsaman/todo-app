variable "environment" {
  type = string
}

variable "instance_config" {
  description = "Configuration for EC2 instance"
  type = object({
    ami_id         = string
    instance_type  = string
    instance_count = number
    key_name       = string
    region         = string
    instance_name  = string
  #  instance_profile_name = string
    vpc_id =string
    subnet_ids = list(string)
  #  alb_security_group_id = string
  #  target_group_arn = string
  #  name = string
 
  })
}



variable "alb_config" {
  type = object({
    public_subnet_ids =  list(string)
    certificate_arn = string
  })
  
}

variable "vpc_id" {
  type = string
}

/*
variable "email_address" {
  description = "VPC ID"
  type = string
}

*/



variable "cloudfront_config" {
    type = object({
        
        price_class = string
        custom_domain = string
        acm_certificate_arn = string
       # origin_id  = string
    })
  
}

variable "region" {
  description = "AWS region"
  type        = string
}





















/*
variable "vpc_config" {
  
  type = object({
    vpc_id = string
  })
}
*/

/*
variable "vpc_config" {
  description = "VPC related config"
  type = object({
    subnet_id = string
  })
}
*/
/*
variable "vpc_id" {
  description = "VPC ID"
  type = string
}
*/

/*
variable "name" {
  description = "Prefix for resource naming"
  type = string
}
*/