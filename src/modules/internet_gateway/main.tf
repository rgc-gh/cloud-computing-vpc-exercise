# Internet Gateway
# resource "aws_internet_gateway" "internet_gateway" {
#   count  = length(local.vpcs_with_igw)
#   vpc_id = module.vpcs[local.vpcs_with_igw_original_indexes[count.index]].id
#   tags = {
#     Name = "igw-${module.vpcs[local.vpcs_with_igw_original_indexes[count.index]].name}"
#   }
# }
