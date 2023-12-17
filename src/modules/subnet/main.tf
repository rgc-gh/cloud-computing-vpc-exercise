# Subnets
resource "aws_subnet" "subnets" {
  count                   = length(local.subnets)
  vpc_id                  = local.subnets[count.index].vpc_id
  cidr_block              = local.subnets[count.index].cidr_block
  availability_zone       = local.subnets[count.index].availability_zone
  map_public_ip_on_launch = local.subnets[count.index].map_public_ip_on_launch

  tags = {
    Name = "subnet-${local.subnets[count.index].tier}-${local.subnets[count.index].availability_zone}"
    Tier = local.subnets[count.index].tier
  }
}

# Route Tables
resource "aws_route_table" "route_tables" {
  count  = length(local.subnets)
  vpc_id = local.subnets[count.index].vpc_id

  tags = {
    Name = "rt-${local.subnets[count.index].tier}-${local.subnets[count.index].availability_zone}"
  }
}

resource "aws_route_table_association" "route_table_associations" {
  count          = length(local.subnets)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.route_tables[count.index].id
}
