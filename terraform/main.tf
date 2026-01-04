terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_module" {
  source     = "./modules/vpc"
  prefix_env = var.prefix_env
}

module "ec2_server" {
  source     = "./modules/ec2"
  subnet_id  = module.vpc_module.subnet_id
  web-sg     = module.vpc_module.web-sg
  prefix_env = var.prefix_env
  user_data  = file("environment.sh")
}