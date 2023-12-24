resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  subnet_id     = var.subnet_id
  allocation_id = aws_eip.nat.id

  tags = merge(
    {
      Name = "nat-${var.name_suffix}"
    },
    var.tags
  )
}
