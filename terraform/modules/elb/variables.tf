
variable "environment" {

  type = string
}

variable "alb_config" {
  type = object({
    public_subnet_ids =  list(string)
   # vpc_id = string
    certificate_arn = string

  })
}
variable "vpc_id" {
  description = "VPC ID"
  type = string
}

/*
variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}
*/