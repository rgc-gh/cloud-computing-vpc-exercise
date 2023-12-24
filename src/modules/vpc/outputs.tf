output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "name" {
  description = "The name of the VPC."
  value       = aws_vpc.this.tags["Name"]
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = module.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = module.private_subnets[*].id
}

output "isolated_subnet_ids" {
  description = "The IDs of the isolated subnets."
  value       = module.isolated_subnets[*].id
}
