output "nat_gateway_id" {
  description = "The ID of the NAT gateway."
  value       = aws_nat_gateway.this.id
}
