data "aws_ecr_image" "service_image" {
  repository_name = "${var.project_name}-${var.environment}"    
  most_recent = true
}

resource "aws_ecs_task_definition" "ecommerce_backend" {
  family                   = "${var.project_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.ecs_task_execution_role
  container_definitions = <<EOF
  [
    {
      "name": "ecommerce-backend-dev",
      "image": "${data.aws_ecr_image.service_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "command": [],
      "environment": [
        {
          "name": "POSTGRES_HOST",
          "value": ""
        },
        {
          "name": "POSTGRES_PORT",
          "value": "5432"
        },
        {
          "name": "POSTGRES_USER",
          "value": "airflow"
        },
        {
          "name": "POSTGRES_PASSWORD",
          "value": "Airflow2021"
        },
        {
          "name": "POSTGRES_DB",
          "value": "airflow"
        },
        {
          "name": "BACKEND_BASE_URL",
          "value": "http://localhost:8080"
        },
        {
          "name": "STAGE",
          "value": "${var.environment}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${var.log_group_name}/${var.project_name}-${var.environment}",
          "awslogs-region": "ap-south-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  EOF
}