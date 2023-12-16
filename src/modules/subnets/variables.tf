variable "subnets" {
  description = "The subnets to create"
  type = list(object({
    vpc_index : number
    cidr_block : string
    availability_zone : string
    is_public : bool
  }))
}

variable "vpc_ids" {
  description = "The VPC ids where to create the subnets"
  type        = list(number)
}
