resource "aws_security_group" "ecommerce_backend_alb_sg" {
  name        = "${var.project_name}-${var.environment}-ALB-SG"
  description = "Allow all inbound traffic"
  vpc_id      = var.ecommerce_app_vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   // give cloudfront ips here
    description = "Inbound backend HTTP from only cloudfront"
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   // give cloudfront ips here
    description = "Inbound backend HTTPS from only cloudfront"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-ALB-SG"
  }
}