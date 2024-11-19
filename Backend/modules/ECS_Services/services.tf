resource "aws_ecs_service" "ecommerce_backend" {
  name                               = "${var.project_name}-${var.environment}-service"
  cluster                            = var.ecs_cluster_name
  task_definition                    = var.ecommerce_backend_taskdef_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [aws_security_group.ecommerce_backend_ecs_internal.id]
    subnets          = [var.ecommerceApp-VPC-private-subnet-one, var.ecommerceApp-VPC-private-subnet-two]
  }

  load_balancer {
    target_group_arn = var.ecommerce_backend_alb_target_group_arn
    container_name   = "${var.project_name}-${var.environment}"
    container_port   = 8080
  }

  depends_on = [
  //var.rds_instance,
  var.ecommerce_backend_listener_arn,
  ]
}