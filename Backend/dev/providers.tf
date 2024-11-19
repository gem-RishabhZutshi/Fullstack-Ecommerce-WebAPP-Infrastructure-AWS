terraform {
  backend "s3" {
    bucket = "ecommerce-app-backend-terraform-state"
    key    = "terraform/ecommerce-app-dev/tf.state"
    region = "ap-south-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45.0"
    }
  }
}
  // required_version = ">= 0.14.9"


# provider
provider "aws" {
  region = "ap-south-1"
}