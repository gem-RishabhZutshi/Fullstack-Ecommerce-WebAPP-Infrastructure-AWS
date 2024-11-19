resource "aws_ecr_repository" "ecommerce_backend_ecr" {
  name = "${var.project_name}-${var.environment}"
}

resource "aws_ecr_lifecycle_policy" "ecommerce_backend_ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecommerce_backend_ecr.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep only the latest 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}