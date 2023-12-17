variable "region" {
  description = "The selected AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cidr" {
  description = "VPC CIDR blocks"
  type = object({
    block_spec : string
    increment : number
  })
  default = {
    block_spec = "10.%d.0.0/16"
    increment  = 10
  }
}

variable "vpcs" {
  type = list(object({
    has_igw : bool
    subnets : list(object({
      availability_zone_index : number
      routes_to_igw : bool
      has_nat : bool
      nat_index : number
    }))
  }))

  validation {
    condition = alltrue([
      for vpc in var.vpcs : alltrue([
        for subnet in vpc.subnets :
        (!subnet.routes_to_igw || vpc.has_igw) &&                                  # The VPC must contain an Internet Gateway for a subnet to route to it.
        (!subnet.routes_to_igw || subnet.nat_index == null) &&                     # It makes no sense to route a subnet to an Internet Gateway and a NAT.
        (subnet.routes_to_igw || !subnet.has_nat) &&                               # It makes no sense to have a NAT in a private subnet.
        (subnet.nat_index == null ? true : subnet.nat_index < length(vpc.subnets)) # One of the subnets routes to a non-existing NAT
      ])
    ])

    error_message = <<-EOT
    Validation failed, you can uncomment the 'outputs.tf' file to check what failed...
    
    Check one of the following:
      - The VPC must contain an Internet Gateway for a subnet to route to it.
      - It makes no sense to route a subnet to an Internet Gateway and a NAT.
      - It makes no sense to have a NAT in a private subnet.
      - One of the subnets routes to a non-existing NAT.
    EOT
  }
}
