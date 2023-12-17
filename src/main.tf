module "vpc" {
  source = "./modules/vpc"
  vpcs   = local.vpcs
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpcs   = local.internet_gateway_vpcs
}

module "subnet" {
  source  = "./modules/subnet"
  subnets = local.subnets
}

module "nat_gateway" {
  source  = "./modules/nat_gateway"
  subnets = local.nat_gateway_subnets
}

module "route_gateway" {
  source  = "./modules/route_gateway"
  subnets = local.route_gateway_subnets
}

module "ec2" {
  source = "./modules/ec2"
}
