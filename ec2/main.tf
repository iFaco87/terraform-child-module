terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
    }
  }

  required_version = "~> 1.9.5"
}

resource "aws_key_pair" "this" {
  for_each   = var.keypairs
  key_name   = each.value.name
  public_key = each.value.public_key
  tags = {
    Name = "${each.value.name}-key"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

data "aws_security_groups" "public" {
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

resource "aws_instance" "this" {
  depends_on                  = [aws_key_pair.this]
  for_each                    = var.instances
  ami                         = var.ami_id
  instance_type               = each.value.instance_type
  key_name                    = each.value.key_name
  subnet_id                   = each.value.subnet_id
  user_data                   = each.value.user_data
  private_ip                  = each.value.private_ip
  secondary_private_ips       = each.value.secondary_private_ips
  vpc_security_group_ids      = each.value.security_group_ids
  associate_public_ip_address = each.value.associate_public_ip_address
  iam_instance_profile        = each.value.instance_profile
  monitoring                  = each.value.monitoring

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
    encrypted   = true
  }

  tags = merge(each.value.extra_tags, {
    Name = each.key
  })
}