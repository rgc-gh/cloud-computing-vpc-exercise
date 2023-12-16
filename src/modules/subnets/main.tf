resource "aws_subnet" "subnet" {
  count                   = length(var.subnets)
  vpc_id                  = var.vpc_ids[var.subnets[count.index].vpc_index]
  cidr_block              = var.subnets[count.index].cidr_block
  availability_zone       = var.subnets[count.index].availability_zone
  map_public_ip_on_launch = var.subnets[count.index].is_public

  tags = {
    Name = "subnet-${var.subnets[count.index].is_public ? "public" : "private"}-${var.subnets[count.index].availability_zone}"
    Tier = var.subnets[count.index].is_public ? "public" : "private"
  }
}
