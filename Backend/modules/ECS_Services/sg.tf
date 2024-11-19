resource "aws_security_group" "ecommerce_backend_ecs_internal" {
  name        = "${var.project_name}-${var.environment}-ecs-internal-sg"
  description = "Allow all backend inbound traffic"
  vpc_id      = var.ecommerce_app_vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-ecs-internal-sg"
  }
}