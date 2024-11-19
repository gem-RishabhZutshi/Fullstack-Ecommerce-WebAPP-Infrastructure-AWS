resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.log_group_name}/${var.project_name}-${var.environment}"
  retention_in_days = 365
}