variable "subnets" {
  description = "The subnets to create"
  type = list(object({
    vpc_id : number
    cidr_block : string
    availability_zone : string
    map_public_ip_on_launch : bool
  }))
}
