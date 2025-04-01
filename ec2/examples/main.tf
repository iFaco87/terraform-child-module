terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
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
  source          = "./../../network"
  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "sg_bastion" {
  source           = "cloudposse/security-group/aws"
  version          = "2.2.0"
  stage            = var.sg_bastion.stage
  attributes       = var.sg_bastion.attributes
  allow_all_egress = var.sg_bastion.allow_all_egress
  vpc_id           = module.network.vpc_id
  rules            = var.sg_bastion.rules
}

module "sg_db" {
  source           = "cloudposse/security-group/aws"
  version          = "2.2.0"
  stage            = var.sg_db.stage
  attributes       = var.sg_db.attributes
  allow_all_egress = var.sg_db.allow_all_egress
  vpc_id           = module.network.vpc_id
  rules            = var.sg_db.rules
}

module "ec2" {
  source    = "./.."
  instances = local.instances
  keypairs  = var.keypairs
}