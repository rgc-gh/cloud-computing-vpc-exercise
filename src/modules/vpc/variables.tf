variable "vpcs" {
  description = "The VPCs to create"
  type = list(object({
    cidr_block : string
    has_internet_gateway : bool
  }))
}
