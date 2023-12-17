variable "subnets" {
  description = "The VPCs to which the NAT gateways will be added"
  type = list(object({
    id : number
    name : string
  }))
}
