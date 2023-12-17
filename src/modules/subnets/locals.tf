locals {
  properties = [for subnet in var.subnets : {
    routes_to_igw = subnet.igw_id != null
    prefix        = subnet.igw_id != null ? "public" : "private"
  }]
}

locals {
  subnets_to_igw        = [for subnet in var.subnets : subnet if subnet.igw_id != null]
  subnets_to_nat        = [for subnet in var.subnets : subnet if subnet.nat_id != null]
  subnet_to_igw_mapping = { for idx, subnet in local.subnets_to_igw : idx => subnet.original_index }
  subnet_to_nat_mapping = { for idx, subnet in local.subnets_to_nat : idx => subnet.original_index }
}
