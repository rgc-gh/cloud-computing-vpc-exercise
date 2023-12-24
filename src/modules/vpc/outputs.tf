output "id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "name" {
  description = "The name of the VPC."
  value       = aws_vpc.this.tags["Name"]
}

output "main_route_table_id" {
  description = "The ID of the main route table of the VPC."
  value       = aws_vpc.this.main_route_table_id
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

output "public_subnet_route_table_ids" {
  description = "The route table IDs of the public subnets."
  value       = module.public_subnets[*].route_table_id
}

output "private_subnet_route_table_ids" {
  description = "The route table IDs of the private subnets."
  value       = module.private_subnets[*].route_table_id
}

output "isolated_subnet_route_table_ids" {
  description = "The route table IDs of the isolated subnets."
  value       = module.isolated_subnets[*].route_table_id
}
