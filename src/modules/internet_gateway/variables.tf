variable "vpcs" {
  description = "The VPC where to create the subnets"
  type = list(object({
    id : number
    name : string
  }))
}

