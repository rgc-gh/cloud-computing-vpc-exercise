# resource "aws_nat_gateway" "nat" {
#   allocation_id = var.eip_id
#   subnet_id     = aws_subnet.subnet_a1.id
#   // Other configurations
# }
