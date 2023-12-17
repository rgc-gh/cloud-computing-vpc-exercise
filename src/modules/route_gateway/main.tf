# NAT Gateway Routes
resource "aws_route" "routes_nat_gateway" {
  count                  = length(local.subnets_to_nat_gateway)
  route_table_id         = local.subnets_to_nat_gateway[count.index].route_table_id
  destination_cidr_block = local.subnets_to_nat_gateway[count.index].destination_cidr_block
  nat_gateway_id         = local.subnets_to_nat_gateway[count.index].nat_gateway_id
}

# Internet Gateway Routes
resource "aws_route" "routes_internet_gateway" {
  count                  = length(local.subnets_to_internet_gateway)
  route_table_id         = local.subnets_to_nat_gateway[count.index].route_table_id
  destination_cidr_block = local.subnets_to_internet_gateway[count.index].destination_cidr_block
  gateway_id             = local.subnets_to_internet_gateway[count.index].internet_gateway_id
}
