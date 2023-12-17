# # Uncomment for variable input validation.
# output "validation-test" {
#   value = [
#     for vpc in var.vpcs : [
#       for subnet in vpc.subnets : {
#         contains_internet_gateway  = !subnet.routes_to_internet_gateway || vpc.has_internet_gateway
#         internet_and_nat_gateways  = !subnet.routes_to_internet_gateway || subnet.nat_gateway_index == null
#         nat_gateway_private_subnet = subnet.routes_to_internet_gateway || !subnet.has_nat_gateway
#         nat_gateway_not_exists     = subnet.nat_gateway_index == null ? true : subnet.nat_gateway_index < length(vpc.subnets)
#       }
#     ]
#   ]
# }

output "OUT1" {
  value = local.newbits
}
