locals {
  vpcs = [
    for vpc in var.vpcs :
    merge(vpc, {
      tier = vpc.has_igw ? "public" : "private"
    })
  ]
}
