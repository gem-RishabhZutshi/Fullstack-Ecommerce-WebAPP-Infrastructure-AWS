variable "project_name" {
  default = "ecommerce_backend"
}

variable "environment" {
  description = "Dev Environment"  
  type = string
}

# variable "ecs_task_execution_role" {
#   type = string
# }

variable "ecommerce_backend_taskdef_arn" {
    type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecommerceApp-VPC-private-subnet-one" {
  type = string
}

variable "ecommerceApp-VPC-private-subnet-two" {
  type = string
}

variable "ecommerce_backend_alb_target_group_arn" {
  type = string
}

variable "ecommerce_backend_listener_arn" {
  type = string
}

variable "ecommerce_app_vpc_id" {
  type = string
}