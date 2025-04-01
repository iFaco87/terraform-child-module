# DO NOT ASSIGN THESE IN THE REPO
variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }

# TO BE DEFINED IN TFVARS
variable "service_name" { type = string }
variable "environment" { type = string }
variable "vpc_cidr_block" { type = string }
variable "private_subnets" { type = map(any) }
variable "public_subnets" { type = map(any) }

# SECURITY GROUP MODULE VARIABLES
variable "sg_bastion" {}
variable "sg_db" {}

# EC2 MODULE VARIABLES
variable "keypairs" {}