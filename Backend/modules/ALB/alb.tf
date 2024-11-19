resource "aws_alb" "ecommerce_backend_alb" {
  name            = "${var.project_name}-${var.environment}-ALB"
  internal = true
  load_balancer_type = "application"
  subnets         = [var.ecommerceApp-VPC-private-subnet-one, var.ecommerceApp-VPC-private-subnet-two]
  security_groups = [aws_security_group.ecommerce_backend_alb_sg.id]
}

resource "aws_alb_target_group" "ecommerce_backend_alb_target_group" {
  name        = "${var.project_name}-${var.environment}-service-TG"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.ecommerce_app_vpc_id
  target_type = "ip"

  health_check {
    interval            = 10
    port                = 8080
    protocol            = "HTTP"
    path                = "/health"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# port exposed from the application load balancer
resource "aws_alb_listener" "ecommerce_backend_listener" {
  load_balancer_arn = aws_alb.ecommerce_backend_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecommerce_backend_alb_target_group.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "ecommerce_backend_listener_https" {
  load_balancer_arn = aws_alb.ecommerce_backend_alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.ecommerce_backend_alb_target_group.id
    type             = "forward"
  }
}