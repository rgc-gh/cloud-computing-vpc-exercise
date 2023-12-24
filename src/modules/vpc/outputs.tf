output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_name" {
  description = "The name of the VPC."
  value       = aws_vpc.this.tags["Name"]
}
