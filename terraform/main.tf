terraform {
  backend "s3" {
    bucket         = "my-tf-state12"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "random_id" "suffix" {
  byte_length = 4
}

module "website" {
  source = "./modules/s3"
  bucket_name = "my-app-${var.environment}-${random_id.suffix.hex}" # var.cloudfront_config.bucket_name
  environment = var.environment
  
}

module "cloudfront_distribution" {
  source = "./modules/cloudfront"

  cloudfront_config = {
    bucket_domain_name           =  module.website.bucket_domain_name
    bucket_name                  =  module.website.bucket_name
    origin_access_identity_path  =  module.website.origin_access_identity_path
    price_class                  =  var.cloudfront_config.price_class
    custom_domain                =  var.cloudfront_config.custom_domain
    acm_certificate_arn         =   var.cloudfront_config.acm_certificate_arn
   #  origin_id                   = "s3-${module.website.bucket_name}" 
  }
   environment = var.environment
}



module "iam" {
  source = "./modules/iam"
  environment =  var.environment
  region = var.instance_config.region 
  aws_account_id = module.ecr.aws_account_id

  
}

module "alb" {
  source = "./modules/elb"

  environment = var.environment
  vpc_id            = var.vpc_id

  alb_config = {
    
    public_subnet_ids = var.alb_config.public_subnet_ids
    certificate_arn   = var.alb_config.certificate_arn
  }
}


module "ecr" {
  source = "./modules/ecr"
  environment =  var.environment
  
}

module "ec2" {
  source = "./modules/ec2"
  environment =  var.environment
  

  instance_config = {
    ami_id =  var.instance_config.ami_id
    instance_type =  var.instance_config.instance_type
    vpc_id =   var.instance_config.vpc_id
    instance_count = var.instance_config.instance_count
    subnet_ids = var.instance_config.subnet_ids
    key_name =  var.instance_config.key_name
     # name = var.instance_config.instance_name
    instance_name         = var.instance_config.instance_name
    region                = var.instance_config.region

# ✅ These must be included
    instance_profile_name = module.iam.instance_profile_name
    alb_security_group_id = module.alb.alb_security_group_id
    target_group_arn      = module.alb.target_group_arn
 
  }
     monitoring_security_group_id = module.monitoring.monitoring_security_group_id
}   









module "monitoring" {
  source = "./modules/monitoring"
  environment =  var.environment
  

  instance_config = {
    ami_id =  var.instance_config.ami_id
    instance_type =  var.instance_config.instance_type
    vpc_id =   var.instance_config.vpc_id
    instance_count = var.instance_config.instance_count
    subnet_ids = var.instance_config.subnet_ids
    key_name =  var.instance_config.key_name
     # name = var.instance_config.instance_name
    instance_name         = var.instance_config.instance_name
    region                = var.instance_config.region

# ✅ These must be included
    instance_profile_name = module.iam.instance_profile_name
    alb_security_group_id = module.alb.alb_security_group_id
    target_group_arn      = module.alb.target_group_arn
    
  }
}   




/*

module "server_cpu_alarm" {
  source = "./modules/cloudwatch"

#  count = var.environment == "prod" ? var.instance_config.instance_count : 0

  alarm_config = {
    alarm_name           = "HighCPUUtilization"
    comparison_operator  = "GreaterThanThreshold"
    evaluation_periods   = 5         # test 1 0r 2
    metric_name          = "CPUUtilization"
    namespace            = "AWS/EC2"
    period               = 300           # test 60
    statistic            = "Average"
    threshold            = 5      # test means: trigger if CPU > 5% for 1 datapoint of 1 minute.
    alarm_description    = "Alarm when CPU exceeds 80%"
   # alarm_actions        = [aws_sns_topic.alarm_topic.arn]
   dimensions = {
    }
  }

  sns_topic_name = "cpu-utilization-alerts"
  email_address  = var.email_address 
  instance_ids   = module.ec2_instance.instance_ids
  # instance_ids   = var.environment == "prod" ? module.ec2_instance.instance_ids : []
}


*/
/*



































module "myserver" {
  source = "./modules/ec2"

  name            = var.name
  vpc_id          = var.vpc_id
  vpc_config      = var.vpc_config

  instance_config = {
    ami_id           = var.instance_config.ami_id
    instance_type = var.instance_config.instance_type
    instance_count         = var.instance_config.instance_count
    key_name      = var.instance_config.key_name
    subnet_id     = var.vpc_config.subnet_id
  }
}

*/
/*
module "dev_ec2" {
  source          = "./modules/ec2_instance"
  name            = var.name
  vpc_id          = var.vpc_id
  instance_config = var.instance_config
  vpc_config      = var.vpc_config
}
*/
