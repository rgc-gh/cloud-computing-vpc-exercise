# Subnet
resource "aws_subnet" "subnet" {
  count                   = length(var.subnets)
  vpc_id                  = var.vpc_ids[var.subnets[count.index].vpc_index]
  cidr_block              = var.subnets[count.index].cidr_block
  availability_zone       = var.subnets[count.index].availability_zone
  map_public_ip_on_launch = local.properties[count.index].routes_to_igw

  tags = {
    Name = "subnet-${local.properties[count.index].prefix}-${var.subnets[count.index].availability_zone}"
    Tier = local.properties[count.index].prefix
  }
}

# Route Table
resource "aws_route_table" "subnet_route_table" {
  count  = length(var.subnets)
  vpc_id = var.vpc_ids[var.subnets[count.index].vpc_index]

  tags = {
    Name = "rt-${local.properties[count.index].prefix}-${var.subnets[count.index].availability_zone}"
  }
}

resource "aws_route_table_association" "subnet_rta" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.subnet_route_table[count.index].id
}

# Route to Internet Gateway
resource "aws_route" "subnet_igw_route" {
  count                  = length(local.subnets_to_igw)
  route_table_id         = aws_route_table.subnet_route_table[local.subnet_to_igw_mapping[count.index]].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.subnet_to_igw_mapping[count.index].igw_id

  depends_on = [aws_route_table.subnet_route_table]
}

# Route to NAT Gateway
resource "aws_route" "subnet_nat_route" {
  count                  = length(local.subnets_to_nat)
  route_table_id         = aws_route_table.subnet_route_table[local.subnet_to_nat_mapping[count.index]].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = local.subnet_to_nat_mapping[count.index].igw_id

  depends_on = [aws_route_table.subnet_route_table]
}
