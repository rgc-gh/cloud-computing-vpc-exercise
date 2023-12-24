locals {
  vpc_max_count = 5
  cidr_blocks   = [for i in range(local.vpc_max_count) : format(var.cidr_block_spec, i * var.cidr_block_increment)]
}

locals {
  public_vpc_cidr_block  = local.cidr_blocks[0]
  private_vpc_cidr_block = local.cidr_blocks[1]
}

locals {
  subnets_per_vpc_count = 4
  newbits               = local.subnets_per_vpc_count > 1 ? floor(log(local.subnets_per_vpc_count - 1, 2)) + 1 : 1 # Number of bits to represent all subnets.

  subnets_total         = pow(2, local.newbits)                                # Total amount of subnets that could be represented given a number of bits.
  subnets_total_half    = local.subnets_total / 2                              # Half of the total amount of subnets that could be represented given a number of bits.
  public_subnets_range  = range(local.subnets_total_half)                      # The first half of the subnets are public.
  private_subnets_range = range(local.subnets_total_half, local.subnets_total) # The second half of the subnets are private.

  public_vpc_public_subnet_cidr_blocks   = [for i in local.public_subnets_range : cidrsubnet(local.public_vpc_cidr_block, local.newbits, i)]
  public_vpc_private_subnet_cidr_blocks  = [for i in local.private_subnets_range : cidrsubnet(local.public_vpc_cidr_block, local.newbits, i)]
  private_vpc_private_subnet_cidr_blocks = [cidrsubnet(local.private_vpc_cidr_block, local.newbits, local.subnets_total_half)]
}

locals {
  tags = {
    Terraform   = "true"
    Environment = "vpc-exercise"
  }
}
