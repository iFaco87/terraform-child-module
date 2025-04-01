variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  nullable    = false
  type        = string
}

variable "enable_network_address_usage_metrics" {
  description = "Enable network address usage metrics"
  default     = false
  type        = bool
}

variable "vpc_name" {
  description = "The name of the VPC"
  default     = "main"
  nullable    = false
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support for the VPC"
  default     = true
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  default     = true
  type        = bool
}

variable "igw_name" {
  description = "The name of the internet gateway"
  default     = "main"
  nullable    = false
  type        = string
}

variable "to_igw_cidr_block" {
  description = "The CIDR block for the route table to the internet gateway"
  default     = "0.0.0.0/0"
  nullable    = false
  type        = string
}

variable "to_nat_cidr_block" {
  description = "The CIDR block for the route table to the NAT gateway"
  default     = "0.0.0.0/0"
  nullable    = false
  type        = string
}

variable "public_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_subnets" {
  type = map(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
}

variable "extra_public_subnet_tags" {
  type        = map(string)
  description = "Extra Tags for Public Subnets"
  default     = null
}

variable "extra_private_subnet_tags" {
  type        = map(string)
  description = "Extra Tags for Private Subnets"
  default     = null
}

variable "extra_vpc_tags" {
  type        = map(string)
  description = "Extra Tags for VPC"
  default     = null
}