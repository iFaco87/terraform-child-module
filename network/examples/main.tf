terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.46.0"
    }
  }
  required_version = "~> 1.9.5"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      Service     = var.service_name
      Environment = var.environment
    }
  }
}

module "network" {
  source          = "./.."
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}