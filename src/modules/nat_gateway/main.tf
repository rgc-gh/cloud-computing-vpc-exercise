resource "aws_nat_gateway" "nat_gateways" {
  count     = length(var.subnets)
  subnet_id = var.subnets[count.index].id
  tags = {
    Name = "nat-${var.subnets[count.index].name}"
  }
}
