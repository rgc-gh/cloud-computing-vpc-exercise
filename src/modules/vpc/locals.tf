locals {
  any_availability_zone = length(var.availability_zones) > 0
}

locals {
  public_subnet_count   = (var.with_internet_gateway && local.any_availability_zone) ? length(var.public_subnet_cidr_blocks) : 0
  private_subnet_count  = local.any_availability_zone ? length(var.private_subnet_cidr_blocks) : 0
  isolated_subnet_count = local.any_availability_zone ? length(var.isolated_subnet_cidr_blocks) : 0
}

locals {
  internet_gateway_route_count = var.with_internet_gateway ? local.public_subnet_count : 0
  nat_gateway_route_count      = var.with_nat_gateway && local.public_subnet_count > 0 ? local.private_subnet_count : 0
}
