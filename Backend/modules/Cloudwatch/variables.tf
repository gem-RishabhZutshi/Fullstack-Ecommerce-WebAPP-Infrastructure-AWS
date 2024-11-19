variable "log_group_name" {
  default = "ecs/fargate"
}

variable "project_name" {
  default = "ecommerce-backend"
}

variable "environment" {
  description = "Dev Environment"  
  type = string
}