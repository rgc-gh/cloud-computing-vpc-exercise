locals {
  route_table_id_count = length(var.route_table_ids)
  cidr_block_count     = length(var.cidr_blocks)
}
