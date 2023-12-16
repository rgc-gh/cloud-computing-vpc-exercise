module "vpc" {
  source = "./modules/vpc"
  vpcs   = local.vpcs
}

module "subnets" {
  source  = "./modules/subnets"
  subnets = local.subnets
  vpc_ids = module.vpc.vpc_ids
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
