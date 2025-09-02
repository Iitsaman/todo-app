# ec2 iam role

resource "aws_iam_role" "ec2_role" {
    name =  "${var.environment}-ec2-ecr-role"
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


# ecr acesss policy for ec2 role 

resource "aws_iam_role_policy" "ecr_access" {
     name =  "${var.environment}-ecr-access" 
     
     role =  aws_iam_role.ec2_role.id

     policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {

        Effect = "Allow"
           Action  = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:BatchGetImage"
    ] 
     Resource = "*"
}
/* ,
{
   Effect = "Allow"
   Principal = {
    AWS = aws_iam_role.ec2_role.arn
   }
    Action = "sts:AssumeRole"
}
*/
]
     })
}


resource "aws_iam_role_policy" "ssm_access" {
  name = "${var.environment}-ssm-access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:GetParametersByPath",
            ]
            Resource = [
              "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/${var.environment}/backend/*"
            ]
        }
    ]
  })
}



# crete a instance profile

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.environment}-ec2-ecr-profile"
  role = aws_iam_role.ec2_role.name
}
