# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name = "vpc-${var.name_suffix}"
    },
    var.tags
  )
}

# Internet Gateways
module "internet_gateways" {
  source = "../internet_gateway"
  count  = var.with_internet_gateway ? 1 : 0

  name_suffix = aws_vpc.this.tags["Name"]
  vpc_id      = aws_vpc.this.id

  tags = var.tags
}

# Subnets
module "public_subnets" {
  source = "../subnet"
  count  = local.public_subnet_count

  name_suffix             = format("public-%s", element(var.availability_zones, count.index))
  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  with_nat_gateway        = var.with_nat_gateway && count.index == var.public_subnet_with_nat_index
  map_public_ip_on_launch = true

  tags = var.tags
}

module "private_subnets" {
  source = "../subnet"
  count  = local.private_subnet_count

  name_suffix       = format("private-%s", element(var.availability_zones, count.index))
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.private_subnet_cidr_blocks[count.index]

  tags = var.tags
}

module "isolated_subnets" {
  source = "../subnet"
  count  = local.isolated_subnet_count

  name_suffix       = format("isolated-%s", element(var.availability_zones, count.index))
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.isolated_subnet_cidr_blocks[count.index]

  tags = var.tags
}

# Routes
resource "aws_route" "internet_gateway_routes" {
  count                  = local.internet_gateway_route_count
  route_table_id         = module.public_subnets[count.index].route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.internet_gateways[0].internet_gateway_id
}

resource "aws_route" "nat_gateway_routes" {
  count                  = local.nat_gateway_route_count
  route_table_id         = module.private_subnets[count.index].route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.public_subnets[var.public_subnet_with_nat_index].nat_gateway_id
}
