

# crete monitoring ec2 isntance
resource "aws_instance" "monitoring" {

  ami           =  var.instance_config.ami_id
  instance_type =  var.instance_config.instance_type
  count =          var.instance_config.instance_count
  key_name      =  var.instance_config.key_name
  subnet_id = element(var.instance_config.subnet_ids, count.index % length(var.instance_config.subnet_ids))
 vpc_security_group_ids =     [ aws_security_group.mo_sg.id ]    
  iam_instance_profile =  aws_iam_instance_profile.monitoring_profile.name
 
  tags = {
    Name =   "${var.environment}-backend-${count.index +1}" 
    Environment = var.environment
  }

}



# sg for instance
resource "aws_security_group" "mo_sg" {
  name        = "${var.environment}-monitoring-sg"
  description = "Security group for monitoring EC2 instance"
  vpc_id      = var.instance_config.vpc_id
  ingress {
    from_port   = 3000   # grafana
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
  ingress {
    from_port   = 9090   # promoth
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
    
  }

  ingress {
    from_port   = 22   # ssh
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
    
  }

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


resource "aws_iam_role" "monitoring_role" {
    name =  "${var.environment}-monitoring-role"
      assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = var.environment
    Name        = "ec2-role-${var.environment}"
  }
  
}



resource "aws_iam_role_policy" "prom_access" {
  name = "${var.environment}-prom-ec2-access"
  role = aws_iam_role.monitoring_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
               "ec2:DescribeInstances",
               "ec2:DescribeTags",
            ]
            Resource = [
              "*"
            ]
        }
    ]
  })
}

resource "aws_iam_instance_profile" "monitoring_profile" {
  name = "${var.environment}-monitoring-profile"
  role = aws_iam_role.monitoring_role.name
}
