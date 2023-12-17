output "ids" {
  value = [for internet_gateway in aws_internet_gateway.internet_gateways : internet_gateway.id]
}
