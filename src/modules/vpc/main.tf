resource "aws_vpc" "vpcs" {
  count                = length(local.vpcs)
  cidr_block           = local.vpcs[count.index].cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${local.vpcs[count.index].tier}"
  }
}
