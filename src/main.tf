module "vpc" {
  source = "./modules/vpc"
  vpcs   = local.vpcs
}

module "subnets" {
  source  = "./modules/subnets"
  subnets = local.subnets
  vpc_ids = [for vpc in module.vpc.vpcs : vpc.id]
}

module "nat-gateway" {
  source = "./modules/nat-gateway"
}

module "internet-gateway" {
  source = "./modules/internet-gateway"
  vpcs   = [module.vpc.vpcs[0]]
}

module "ec2" {
  source = "./modules/ec2"
}
