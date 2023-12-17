# Subnet
resource "aws_subnet" "subnets" {
  count                   = length(local.subnets)
  vpc_id                  = local.subnets[count.index].vpc_id
  cidr_block              = local.subnets[count.index].cidr_block
  availability_zone       = local.subnets[count.index].availability_zone
  map_public_ip_on_launch = local.subnets[count.index].routes_to_igw

  tags = {
    Name = "subnet-${local.subnets[count.index].tier}-${local.subnets[count.index].availability_zone}"
    Tier = local.subnets[count.index].tier
  }
}

# Route Table
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

# NAT Gateway Routes
resource "aws_route" "routes_nat" {
  count                  = length(local.subnets_to_nat)
  route_table_id         = aws_route_table.route_tables[local.subnets_to_nat_original_indexes[count.index]].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = local.subnets_to_nat_original_indexes[count.index].igw_id
}

# Internet Gateway Routes
resource "aws_route" "routes_igw" {
  count                  = length(local.subnets_to_igw)
  route_table_id         = aws_route_table.route_tables[local.subnets_to_igw_original_indexes[count.index]].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.subnets_to_igw_original_indexes[count.index].igw_id
}

# VPC Peering Routes
