locals {
  # The CIDR block of each VPC (if increment = 10 and block_spec = 10.%d.0.0/16 -> 10.0.0.0/16, 10.10.0.0/16, 10.20.0.0/16, ...)
  cidr_blocks = [for i in range(var.vpc_count) : format(var.cidr.block_spec, i * var.cidr.increment)]

  # The number of bits needed to represent all VPCs.
  newbits = var.vpc_count > 0 ? floor(log(var.vpc_count, 2)) + 1 : 0
}

locals {
  # The VPCs and subnets of the infrastructure.
  vpcs_with_subnets = [
    {
      cidr_block = local.cidr_blocks[0]
      is_public  = true,
      subnets = flatten([
        for i in range(min(var.availability_zones_count, length(data.aws_availability_zones.available.names))) : [
          for j in range(var.subnets_count) : {
            vpc_index         = 0
            cidr_block        = cidrsubnet(local.cidr_blocks[0], local.newbits, j + (var.subnets_count * i))
            availability_zone = data.aws_availability_zones.available.names[i]
            is_public         = j == 0
          }
        ]
      ])
    },
    {
      cidr_block = local.cidr_blocks[1]
      is_public  = false,
      subnets = [
        {
          vpc_index         = 1
          cidr_block        = cidrsubnet(local.cidr_blocks[1], local.newbits, 0)
          availability_zone = data.aws_availability_zones.available.names[0]
          is_public         = false
        }
      ]
    }
  ]
  vpcs = [for vpc in local.vpcs_with_subnets : {
    cidr_block = vpc.cidr_block
    is_public  = vpc.is_public
  }]
  subnets = concat([for vpc in local.vpcs_with_subnets : vpc.subnets]...)
}

