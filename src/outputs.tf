# output "validation-test" {
#   value = [
#     for vpc in var.vpcs : [
#       for subnet in vpc.subnets : {
#         contains_igw       = !subnet.routes_to_igw || vpc.has_igw
#         igw_and_nat        = !subnet.routes_to_igw || subnet.nat_index == null
#         nat_private_subnet = subnet.routes_to_igw || !subnet.has_nat
#         nat_not_exists     = subnet.nat_index == null ? true : subnet.nat_index < length(vpc.subnets)
#       }
#     ]
#   ]
# }
