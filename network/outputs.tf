output "vpc_id" {
  value = try(aws_vpc.this.id, null)
}

output "vpc_arn" {
  value = try(aws_vpc.this.arn, null)
}

output "public_subnet_ids" {
  value = try([for subnet in aws_subnet.public_subnets : subnet.id], null)
}

output "private_subnet_ids" {
  value = try([for subnet in aws_subnet.private_subnets : subnet.id], null)
}

output "private_route_table_ids" {
  value = try([for routetable in aws_route_table.to_nat : routetable.id], null)
}

output "public_subnet_arns" {
  value = try([for subnet in aws_subnet.public_subnets : subnet.arn], null)
}

output "private_subnet_arns" {
  value = try([for subnet in aws_subnet.private_subnets : subnet.arn], null)
}

output "internet_gateway_id" {
  value = try(aws_internet_gateway.this.id, null)
}

output "internet_gateway_arn" {
  value = try(aws_internet_gateway.this.arn, null)
}

output "nat_gateway_ids" {
  value = try([for natgateway in aws_nat_gateway.this : natgateway.id], null)
}

output "nat_gateway_arns" {
  value = try([for natgateway in aws_nat_gateway.this : natgateway.arn], null)
}