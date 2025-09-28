provider "aws" {
  region = "us-east-1"
}

# BACKEND EC2 INSTANCE

# 1.sg for instance
resource "aws_security_group" "my_sg" {
  name        = "${var.environment}-backend-sg"
  description = "Security group for backend EC2 instance"
  vpc_id      = var.instance_config.vpc_id
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    security_groups =  [var.instance_config.alb_security_group_id]
    
  }
  /*

    ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    security_groups =  [var.monitoring_security_group_id]
    
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = [var.monitoring_security_group_id]
    description = "Allow application metrics scraping"
  }

  */
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
     Name = "${var.environment}-backend-sg"
     Environment = var.environment
   }

}

# 2. crete backend ec2 isntance
resource "aws_instance" "my_instance" {

  ami           =  var.instance_config.ami_id
  instance_type =  var.instance_config.instance_type
  count =          var.instance_config.instance_count
 # vpc_id =   var.instance_config.vpc_id
  key_name      =  var.instance_config.key_name
  subnet_id = element(var.instance_config.subnet_ids, count.index % length(var.instance_config.subnet_ids))

  vpc_security_group_ids = [aws_security_group.my_sg.id, aws_security_group.ssh.id ]           
  iam_instance_profile = var.instance_config.instance_profile_name
 
# 👇 This defines storage
#  root_block_device {
#    volume_size = 20         # Size in GB
#    volume_type = "gp3"      # gp2, gp3, io1, etc.
#    delete_on_termination = true

  tags = {
    Name =   "${var.environment}-backend" 
    Environment = var.environment
  }

}

# 3. sg for ssh acesss

resource "aws_security_group" "ssh" {
  name = "${var.environment}-ssh-sg"
  description = "sg for ssh acess"
  vpc_id      = var.instance_config.vpc_id

   ingress {
   
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
     Name = "${var.environment}-ssh-sg"
     Environment = var.environment
   }
}



resource "aws_lb_target_group_attachment" "backend_tgroup" {
  count =  var.instance_config.instance_count 
  target_group_arn =  var.instance_config.target_group_arn
  target_id =  aws_instance.my_instance[count.index].id
  port =  3001
  lifecycle {
    create_before_destroy = true
  }
}


# subnet_id =           var.vpc_config.subnet_id
 # can pass vpc_id = in config
 # subnet_id =         element(var.vpc_config.subnet_ids,count.index % length(var.instance_config.sybnet_ids)
 #subnet_id = element(var.vpc_config.subnet_ids, count.index % length(var.vpc_config.subnet_ids))
# Only use this if you are deploying to multiple subnets. Otherwise keep using var.vpc_config.subnet_id.


