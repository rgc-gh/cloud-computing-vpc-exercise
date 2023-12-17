variable "vpcs" {
  description = "The VPCs to which the Internet gateways will be added"
  type = list(object({
    id : number
    name : string
  }))
}
