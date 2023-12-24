# VPC Peering Connections
resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = var.vpc_id
  auto_accept = true

  tags = merge(
    {
      Name = "vpc-peering-conn-${var.name_suffix}"
    },
    var.tags
  )
}

# Routes
resource "aws_route" "vpc_peering_connection_route" {
  route_table_id            = var.vpc_route_table_id
  destination_cidr_block    = var.peer_vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
