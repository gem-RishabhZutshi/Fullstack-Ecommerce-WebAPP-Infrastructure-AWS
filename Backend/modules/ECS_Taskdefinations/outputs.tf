output "ecommerce_backend_taskdef_arn" {
    value = aws_ecs_task_definition.ecommerce_backend.arn
}

output "ecs_task_image" {
  value = "${replace(jsonencode("${var.ecommerce_backend_ecr_repository_url}:${var.image_version}"), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
}
