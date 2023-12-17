locals {
  subnets = [
    for subnet in var.subnets :
    merge(subnet, {
      tier = subnet.map_public_ip_on_launch ? "public" : "private"
    })
  ]
}
