output "vpcs" {
  value = [for vpc in aws_vpc.vpcs : {
    id   = vpc.id
    name = vpc.tags["Name"]
  }]
}
