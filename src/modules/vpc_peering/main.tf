# VPC Peering Connections
resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = var.requester_vpc_id
  auto_accept = true

  tags = merge(
    {
      Name = "pcx-${var.name_suffix}"
    },
    var.tags
  )
}

# Routes
resource "aws_route" "routes" {
  count = local.route_table_id_count == local.cidr_block_count ? local.route_table_id_count : 0

  route_table_id            = var.route_table_ids[count.index]
  destination_cidr_block    = var.cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
