module "vpc" {
  source = "./modules/vpc"
  vpcs   = local.vpcs
}

module "internet-gateway" {
  source = "./modules/internet_gateway"
}

module "subnets" {
  source  = "./modules/subnets"
  subnets = local.subnets
}

module "nat-gateway" {
  source = "./modules/nat_gateway"
}

module "ec2" {
  source = "./modules/ec2"
}
