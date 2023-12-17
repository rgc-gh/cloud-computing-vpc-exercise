locals {
  vpc_count    = length(var.vpcs)
  subnet_count = [for vpc in var.vpcs : length(vpc.subnets)]
}

locals {
  cidr_blocks = [
    for i in range(local.vpc_count) :
    format(var.cidr.block_spec, i * var.cidr.increment)
  ]                                                                      # The CIDR block of each VPC.
  newbits = local.vpc_count > 0 ? floor(log(local.vpc_count, 2)) + 1 : 0 # Number of bits needed to represent all VPCs.
}

locals {
  vpcs = [
    for i in range(local.vpc_count) : {
      cidr_block = local.cidr_blocks[i]
      has_igw    = var.vpcs[i].has_igw
    }
  ]
}

locals {
  subnets = [
    for i in range(local.vpc_count) : [
      for j in range(local.subnet_count[i]) : {
        vpc_id            = module.vpc.vpcs[i].id
        cidr_block        = cidrsubnet(local.cidr_blocks[0], local.newbits, j + (local.subnet_count[i] * i))
        availability_zone = data.aws_availability_zones.available.names[var.vpcs[i].subnets[j].availability_zone_index]
      }
    ]
  ]
}
