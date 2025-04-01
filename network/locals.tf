locals {
  public_nat_gateway_allocation_ids_map = zipmap(
    [for si in aws_subnet.public_subnets : si.id],
    [for eip in aws_eip.nat : eip.id]
  )
  private_route_table_associations_map = zipmap(
    [for rt in aws_route_table.to_nat : rt.id],
    [for si in aws_subnet.private_subnets : si.id]
  )
}