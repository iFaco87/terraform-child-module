terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
  }
  required_version = "~> 1.9.5"
}

# VPC AND IGW
resource "aws_vpc" "this" {
  cidr_block                           = var.vpc_cidr_block
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  enable_dns_support                   = var.enable_dns_support
  enable_dns_hostnames                 = var.enable_dns_hostnames

  tags = merge(var.extra_vpc_tags, {
    Name = var.vpc_name
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "to_igw" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.to_igw_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Type = "public"
  }
}

# PUBLIC AND PRIVATE SUBNETS
resource "aws_subnet" "public_subnets" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(var.extra_public_subnet_tags, {
    Name = each.value.name
    Type = "public"
  })
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.to_igw.id
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(var.extra_private_subnet_tags, {
    Name = each.value.name
    Type = "private"
  })
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.private_subnets
  domain   = "vpc"
}

resource "aws_nat_gateway" "this" {
  for_each      = aws_subnet.public_subnets
  allocation_id = local.public_nat_gateway_allocation_ids_map[each.value.id]
  subnet_id     = each.value.id
  depends_on    = [aws_internet_gateway.this]
}

resource "aws_route_table" "to_nat" {
  for_each = aws_nat_gateway.this
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block     = var.to_nat_cidr_block
    nat_gateway_id = each.value.id
  }
  tags = {
    Type = "private"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = aws_route_table.to_nat
  subnet_id      = local.private_route_table_associations_map[each.value.id]
  route_table_id = each.value.id
}