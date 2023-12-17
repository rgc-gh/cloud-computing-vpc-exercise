variable "subnets" {
  description = "The subnets to which the gateways will be routed"
  type = list(object({
    route_table_id : number
    destination_cidr_block : string
    routes_to_nat_gateway : bool
    nat_gateway_id : number
    routes_to_internet_gateway : bool
    internet_gateway_id : number
  }))
}
