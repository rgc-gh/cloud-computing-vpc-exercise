variable "subnets" {
  description = "The subnets to create"
  type = list(object({
    vpc_id : number
    cidr_block : string
    availability_zone : string
    igw_id : number
    nat_id : number
  }))
}
