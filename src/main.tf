# VPCs
module "public_vpc" {
  source = "./modules/vpc"

  name_suffix = "public"
  cidr_block  = local.public_vpc_cidr_block

  with_internet_gateway = true
  with_nat_gateway      = true

  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  public_subnet_cidr_blocks  = local.public_vpc_public_subnet_cidr_blocks
  private_subnet_cidr_blocks = local.public_vpc_private_subnet_cidr_blocks

  tags = local.tags
}

module "private_vpc" {
  source = "./modules/vpc"

  name_suffix = "private"
  cidr_block  = local.private_vpc_cidr_block

  availability_zones = [data.aws_availability_zones.available.names[0]]

  isolated_subnet_cidr_blocks = [local.private_vpc_private_subnet_cidr_blocks[0]]

  tags = local.tags
}

# EC2 Instances
module "public_ec2" {
  source = "./modules/ec2"

  public_key_path = var.public_key_path

  vpc_id             = module.public_vpc.id
  inbound_cidr_block = var.inbound_cidr_block

  name_suffix                 = "public"
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  subnet_id                   = module.public_vpc.public_subnet_ids[1]

  tags = local.tags
}

module "private_ec2" {
  source = "./modules/ec2"

  public_key_path = var.public_key_path

  vpc_id             = module.public_vpc.id
  inbound_cidr_block = local.public_vpc_public_subnet_cidr_blocks[1]

  name_suffix   = "private"
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = module.public_vpc.private_subnet_ids[1]

  tags = local.tags
}

module "isolated_ec2" {
  source = "./modules/ec2"

  public_key_path = var.public_key_path

  vpc_id = module.private_vpc.id

  name_suffix   = "isolated"
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = module.private_vpc.isolated_subnet_ids[0]

  tags = local.tags
}
