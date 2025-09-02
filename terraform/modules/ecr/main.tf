
resource "aws_ecr_repository" "backend" {
  name = "${var.environment}-todo-backend"
  image_tag_mutability = "MUTABLE" 

    image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Name        = "${var.environment}-ecr-repo"
  }

}


resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository =  aws_ecr_repository.backend.name
 
  policy =  jsonencode({
    rules = [
       {
        rulePriority = 1
        description  = " keep last 10 images only"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          #countUnit     = "days"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      } 
    ]
  })
}