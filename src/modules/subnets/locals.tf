locals {
  subnets = [
    for subnet in var.subnets :
    merge(subnet, {
      routes_to_nat = subnet.nat_id != null
      routes_to_igw = subnet.igw_id != null
      tier          = subnet.igw_id != null ? "public" : "private"
    })
  ]
}

locals {
  subnets_to_nat                  = [for subnet in local.subnets : subnet if subnet.routes_to_nat]
  subnets_to_nat_original_indexes = { for index, subnet in local.subnets_to_nat : index => subnet.original_index }
}

locals {
  subnets_to_igw                  = [for subnet in local.subnets : subnet if subnet.routes_to_igw]
  subnets_to_igw_original_indexes = { for index, subnet in local.subnets_to_igw : index => subnet.original_index }
}
