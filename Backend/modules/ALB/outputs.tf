output "ecommerce_backend_alb_target_group_arn" {
  value = aws_alb_target_group.ecommerce_backend_alb_target_group.arn
}

output "ecommerce_backend_listener_arn" {
  value = aws_alb_listener.ecommerce_backend_listener.arn
}