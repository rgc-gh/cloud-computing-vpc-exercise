variable "vpcs" {
  description = "The VPCs to create"
  type = list(object({
    cidr_block : string
    is_public : bool
  }))
}
