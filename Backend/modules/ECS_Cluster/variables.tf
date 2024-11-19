variable "project_name" {
  default = "ecommerce_backend"
}

variable "environment" {
  description = "Dev Environment"  
  type = string
}

variable "log_group_name" {
  default = "ecs/fargate"
}

variable "ecommerce_backend_service_name" {
  type = string
}