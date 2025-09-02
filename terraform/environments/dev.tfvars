
region = "us-east-1"
environment= "dev"
vpc_id = "vpc-0de67675bf85e2ef2"

alb_config = {
  public_subnet_ids = [
    "subnet-01fba89e35ff38db4",
    "subnet-06f5454ae2a346329"
  ]
  certificate_arn = "arn:aws:acm:us-east-1:221082199107:certificate/67897093-3492-4ccf-a144-104487e654a0"
}

instance_config = {
  ami_id         = "ami-0360c520857e3138f"
  instance_type  = "t2.micro"
  instance_count = 1
  key_name       = "us-myserve"
  instance_name  = "dev-ec2"
  vpc_id = "vpc-0de67675bf85e2ef2"
  subnet_ids = [
    "subnet-01fba89e35ff38db4",
    "subnet-06f5454ae2a346329"
  ]
  region = "us-east-1"
  #name = "dev"

}


# email_address = "





cloudfront_config = {
 # bucket_name         = "my-dev-app-site12"
  price_class         = "PriceClass_100"
  custom_domain       = "dev.devhelp.site"
  acm_certificate_arn = "arn:aws:acm:us-east-1:221082199107:certificate/67897093-3492-4ccf-a144-104487e654a0"
}



#vpc_config = {
#  subnet_id = "subnet-xxxxxxxx" # Replace with actual subnet
#}

#tags = {
#  Environment = "dev"
#  Project     = "TerraformDemo"
#}


# $env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
# $env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"

#  $env:AWS_DEFAULT_REGION = "us-east-1"


#  terraform init
#  terraform plan -var-file="dev.tfvars"
#  terraform apply -var-file="dev.tfvars"

# terraform plan -var-file="environments/dev.tfvars"

# terraform apply -var-file="environments/dev.tfvars"

# terraform destroy -var-file="environments/dev.tfvars"


/*
email_address = "you@example.com"

alarm_config = {
  alarm_name           = "high-cpu-ec2-alarm"
  comparison_operator  = "GreaterThanThreshold"
  evaluation_periods   = 2
  metric_name          = "CPUUtilization"
  namespace            = "AWS/EC2"
  period               = 120
  statistic            = "Average"
  threshold            = 70
  alarm_description    = "CPU usage is above 70% on EC2"
  dimensions           = {
    InstanceId = "i-0123456789abcdef0"  # Replace with your actual EC2 ID
  }
}


*/


