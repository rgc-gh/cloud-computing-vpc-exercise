output "vpc_ids" {
  value = aws_vpc.vpc[*].id
}
