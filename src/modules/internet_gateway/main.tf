resource "aws_internet_gateway" "igw" {
  count  = length(var.vpcs)
  vpc_id = var.vpcs[count.index].id
  tags = {
    Name = "igw-${var.vpcs[count.index].name}"
  }
}
