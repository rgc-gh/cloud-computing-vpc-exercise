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

# 
# data.aws_ami.ubuntu.id

# <<EOF
# #!/bin/bash
# # User configuration
# usermod -c ${var.system_user} -l ${var.system_user} -d /home/${var.system_user} -m ${var.system_default_user} && groupmod -n ${var.system_user} ${var.system_default_user};
# echo "${var.system_user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-cloud-init-users
# curl -sq https://github.com/${var.github_user}.keys | tee -a /home/${var.system_user}/.ssh/authorized_keys
# # Package installation
# sudo apt update
# sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common jq docker.io cgroup-tools tree
# usermod -aG docker ${var.system_user}
# EOF
