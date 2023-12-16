resource "aws_vpc" "vpc" {
  count                = length(var.vpcs)
  cidr_block           = var.vpcs[count.index].cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.vpcs[count.index].is_public ? "public" : "private"}"
  }
}
