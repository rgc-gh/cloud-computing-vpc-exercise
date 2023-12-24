output "subnet_id" {
  description = "The ID of the subnet."
  value       = aws_subnet.this.id
}

output "subnet_name" {
  description = "The name of the subnet."
  value       = aws_subnet.this.tags["Name"]
}

output "route_table_id" {
  description = "The id of the route table."
  value       = aws_route_table.this.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT gateway."
  value       = var.with_nat_gateway ? module.nat_gateways[0].nat_gateway_id : null
}
