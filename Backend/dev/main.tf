module "VPC" {
  source = "../modules/VPC"
  environment= "dev"
}

module "IAM" {
  source = "../modules/IAM"
}

module "ECS_Taskdefinations" {
  source = "../modules/ECS_Taskdefinations"
  environment = "dev"
  ecs_task_execution_role = module.IAM.ecs_task_execution_role
  ecommerce_backend_ecr_repository_url = module.ECR.ecommerce_backend_ecr_repository_url
}

module "ECS_Services" {
  source = "../modules/ECS_Services"
  environment = "dev"
  ecommerce_backend_taskdef_arn = module.ECS_Taskdefinations.ecommerce_backend_taskdef_arn
  ecommerceApp-VPC-private-subnet-two = module.VPC.ecommerceApp-VPC-private-subnet-two
  ecommerceApp-VPC-private-subnet-one = module.VPC.ecommerceApp-VPC-private-subnet-one
  ecommerce_app_vpc_id = module.VPC.ecommerce_app_vpc_id
  ecommerce_backend_alb_target_group_arn = module.ALB.ecommerce_backend_alb_target_group_arn
  ecommerce_backend_listener_arn = module.ALB.ecommerce_backend_listener_arn
  ecs_cluster_name = module.ECS_Cluster.ecs_cluster_name
}

module "ECS_Cluster" {
  source = "../modules/ECS_Cluster"
  environment = "dev"
  ecommerce_backend_service_name = module.ECS_Services.ecommerce_backend_service_name
}

module "ECR" {
  source = "../modules/ECR"
  environment = "dev"
}

# module "Cloudwatch" {
#   source = "../modules/Cloudwatch"
#   environment = "dev"
# }

module "ALB" {
  source = "../modules/ALB"
  environment = "dev"
  ecommerceApp-VPC-public-subnet-two = module.VPC.ecommerceApp-VPC-public-subnet-two
  ecommerceApp-VPC-public-subnet-one = module.VPC.ecommerceApp-VPC-public-subnet-one
  ecommerceApp-VPC-private-subnet-two = module.VPC.ecommerceApp-VPC-private-subnet-two
  ecommerceApp-VPC-private-subnet-one = module.VPC.ecommerceApp-VPC-private-subnet-one
  ecommerce_app_vpc_id = module.VPC.ecommerce_app_vpc_id
}