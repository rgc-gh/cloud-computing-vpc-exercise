output "vpcs" {
  value = [for vpc in aws_vpc.vpc : {
    id   = vpc.id
    name = vpc.tags["Name"]
  }]
}
