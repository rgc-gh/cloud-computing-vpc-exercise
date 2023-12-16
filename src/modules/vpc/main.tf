resource "aws_vpc" "vpc-public" {
  cidr_block = var.vpc-public-cidr
}

resource "aws_vpc" "vpc-private" {
  cidr_block = var.vpc-private-cidr
}
