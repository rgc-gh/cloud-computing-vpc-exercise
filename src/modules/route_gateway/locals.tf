locals {
  subnets_to_nat_gateway      = [for subnet in var.subnets : subnet if subnet.routes_to_nat_gateway]
  subnets_to_internet_gateway = [for subnet in var.subnets : subnet if subnet.routes_to_internet_gateway]
}
