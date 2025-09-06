

resource "aws_security_group" "alb_sg" {
   name = "${var.environment}-alb-sg"
   description = "sg for ALB"
   vpc_id =  var.vpc_id

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name        = "${var.environment}-alb-sg"
    Environment = var.environment
  }

}


resource "aws_lb" "backend_lb" {
  name               =  "${var.environment}-backend-alb"
  internal           =  false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            =   var.alb_config.public_subnet_ids

  tags = {
    Name        = "${var.environment}-backend-alb"
    Environment = var.environment
  }

}

resource "random_string" "target_group_suffix" {
  length =  4
  special = false
  upper =    false
}

resource "aws_lb_target_group" "my_target_group" {
   name =  "${var.environment}-backend-tg-${random_string.target_group_suffix.result}"
   port =  3001
   protocol = "HTTP"
   vpc_id = var.vpc_id # var.alb_config.vpc_id

 health_check {
  enabled = true 
    path                =   "/api/health"  #"/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
    port =    "traffic-port"


 }

 lifecycle {
   create_before_destroy = true 
 }

 tags = {
   Name = "${var.environment}-backend-${random_string.target_group_suffix.result}"
 }

}

resource "aws_lb_listener" "https_listener" {
   load_balancer_arn = aws_lb.backend_lb.arn
   port              = 443
   protocol          = "HTTPS"
   ssl_policy =         "ELBSecurityPolicy-2016-08"
   certificate_arn   = var.alb_config.certificate_arn
#  certificate_arn   = ""  # var.acm_certificate_arn
 default_action {
    type             = "forward"
     target_group_arn = aws_lb_target_group.my_target_group.arn
 }


 lifecycle {
   create_before_destroy = true
 }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.backend_lb.arn
   port              = 80
  protocol          = "HTTP"
  

 default_action {
    type             = "redirect"
    redirect {
      port =  443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
     
 }

 lifecycle {
   create_before_destroy = true
 }

}






/*
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
*/