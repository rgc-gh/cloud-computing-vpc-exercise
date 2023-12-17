resource "aws_internet_gateway" "internet_gateways" {
  count  = length(var.vpcs)
  vpc_id = var.vpcs[count.index].id
  tags = {
    Name = "igw-${var.vpcs[count.index].name}"
  }
}
