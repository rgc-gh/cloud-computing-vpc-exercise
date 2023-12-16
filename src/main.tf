module "vpc" {
  source           = "./modules/vpc"
  vpc-public-cidr  = var.vpc-public-cidr
  vpc-private-cidr = var.vpc-private-cidr
}

module "subnets" {
  source = "./modules/subnets"
}

module "nat-gateway" {
  source = "./modules/nat-gateway"
}

module "internet-gateway" {
  source = "./modules/internet-gateway"
}

module "ec2" {
  source = "./modules/ec2"
}
