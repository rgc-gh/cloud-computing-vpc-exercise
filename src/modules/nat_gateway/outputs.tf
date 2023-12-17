output "ids" {
  value = [for nat_gateway in aws_nat_gateway.nat_gateways : nat_gateway.id]
}
