variable "project_name" {
  default = "ecommerce-backend"
}

variable "environment" {
  description = "Dev Environment"  
  type = string
}

variable "ecs_task_execution_role" {
  type = string
}

variable "image_version" {
  default = "latest"
}

variable "ecommerce_backend_ecr_repository_url" {
  type = string
}