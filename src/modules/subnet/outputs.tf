output "subnets" {
  value = [for subnet in aws_subnet.subnets : {
    id   = subnet.id
    name = subnet.tags["Name"]
  }]
}
