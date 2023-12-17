locals {
  vpcs_count  = length(var.vpcs)
  cidr_blocks = [for i in range(local.vpcs_count) : format(var.cidr.block_spec, i * var.cidr.increment)]         # The CIDR block of each VPC.
  newbits     = [for vpc in var.vpcs : length(vpc.subnets) > 1 ? floor(log(length(vpc.subnets) - 1, 2)) + 1 : 1] # Number of bits needed to represent all subnets in each VPC.
}

locals {
  vpcs = [
    for index, vpc in var.vpcs : {
      cidr_block           = local.cidr_blocks[index]
      has_internet_gateway = vpc.has_internet_gateway
    }
  ]
  vpcs_with_internet_gateway = [for vpc in var.vpcs : vpc if vpc.has_internet_gateway]
}

locals {
  internet_gateway_vpcs = [
    for index, _ in local.vpcs_with_internet_gateway : {
      id   = module.vpc.vpcs[index].id
      name = module.vpc.vpcs[index].name
    }
  ]
}

locals {
  subnets = flatten([
    for index_vpc, vpc in var.vpcs : [
      for index_subnet, subnet in vpc.subnets : {
        vpc_id                  = module.vpc.vpcs[index_vpc].id
        cidr_block              = cidrsubnet(local.cidr_blocks[index_vpc], local.newbits[index_vpc], index_subnet)
        availability_zone       = data.aws_availability_zones.available.names[subnet.availability_zone_index]
        map_public_ip_on_launch = subnet.routes_to_internet_gateway
      }
    ]
  ])
  subnets_to_nat_gateway = flatten([
    for vpc in var.vpcs : [
      for subnet in vpc.subnets :
      subnet if subnet.has_nat_gateway
    ]
  ])
}

locals {
  nat_gateway_subnets = [
    for index, _ in local.subnets_to_nat_gateway : {
      id   = module.subnet.subnets[index].id
      name = module.subnet.subnets[index].name
    }
  ]
}

locals {
  route_gateway_subnets = flatten([
    for index_vpc, vpc in var.vpcs : [
      for index_subnet, subnet in vpc.subnets : {
        route_table_id         = module.subnet.subnets[index_subnet].id
        destination_cidr_block = "0.0.0.0/0"
        routes_to_nat_gateway  = subnet.nat_gateway_subnet_index != null
        nat_gateway_id = (
          subnet.nat_gateway_subnet_index != null ?
          module.nat_gateway.ids[index(local.subnets_to_nat_gateway, vpc.subnets[subnet.nat_gateway_subnet_index])] :
          null
        )
        routes_to_internet_gateway = subnet.routes_to_internet_gateway
        internet_gateway_id        = subnet.routes_to_internet_gateway ? module.internet_gateway.ids[index(local.vpcs_with_internet_gateway, vpc)] : null
      }
    ]
  ])
}
