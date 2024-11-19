variable "project_name" {
  default = "ecommerce-backend"
}

variable "environment" {
  description = "Dev Environment"  
  type = string
}

# variable "certificate_arn" {
#   default = "arn:aws:acm:us-east-1:791167451670:certificate/74464c2d-fd4b-438f-be41-13b8f9a69cc7"
# }

variable "ecommerce_app_vpc_id" {
  type = string
}

variable "ecommerceApp-VPC-public-subnet-one" {
  type = string
}

variable "ecommerceApp-VPC-public-subnet-two" {
  type = string
}

variable "ecommerceApp-VPC-private-subnet-one" {
  type = string
}

variable "ecommerceApp-VPC-private-subnet-two" {
  type = string
}