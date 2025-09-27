variable "instance_config" {
  description = "Configuration for EC2 instance"
  type = object({
    ami_id         = string
    instance_type  = string
    instance_count = number
    key_name       = string
    region         = string
    instance_name  = string
    instance_profile_name = string
    vpc_id =string
    subnet_ids = list(string)
    alb_security_group_id = string
    target_group_arn = string
  #  name = string
 
  })
}

variable "environment" {
  type = string
}


variable "monitoring_security_group_id" {
  type = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}





/*
variable "name" {
  description = "Prefix for resource naming"
  type        = string
}
*/

/*
variable "vpc_config" {
  description = "Network configuration"
  type = object({
    subnet_id = string
  })
}
*/
/*
variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}
*/


/*
variable "security_group_id" {
  description = "Existing security group ID"
  type        = string
  default     = null
}




variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

*/
