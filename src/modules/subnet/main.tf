# Subnet
resource "aws_subnet" "this" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = "subnet-${var.name_suffix}"
    },
    var.tags
  )
}

# Route Table
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "rt-${var.name_suffix}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

# NAT Gateways
module "nat_gateways" {
  source = "../nat_gateway"
  count  = var.with_nat_gateway ? 1 : 0

  name_suffix = format(aws_subnet.this.tags["Name"])
  subnet_id   = aws_subnet.this.id

  tags = var.tags
}
