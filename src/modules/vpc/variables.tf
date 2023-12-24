# VPC
variable "name_suffix" {
  description = "The Name tag suffix of the VPC."
  type        = string
}

variable "cidr_block" {
  description = "The VPC IPv4 CIDR block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The names of availability zones to use in the VPC."
  type        = list(string)
}

variable "with_internet_gateway" {
  description = "If set, the VPC will contain an internet gateway and all public subnets will route to it."
  type        = bool
  default     = false
}

variable "with_nat_gateway" {
  description = "If set, the first public subnet will contain a NAT gateway and all private subnets will route to it."
  type        = bool
  default     = false
}

variable "public_subnet_with_nat_index" {
  description = "The index of the subnet to contain the NAT gateway, if set."
  type        = number
  default     = 0
}

# Subnets
variable "public_subnet_cidr_blocks" {
  description = "The subnets IPv4 CIDR blocks, by availability zone index, that will route to an internet gateway."
  type        = list(string)
  default     = []
}

variable "private_subnet_cidr_blocks" {
  description = "The subnets IPv4 CIDR blocks, by availability zone index, that will route to a NAT gateway."
  type        = list(string)
  default     = []
}

variable "isolated_subnet_cidr_blocks" {
  description = "The subnets IPv4 CIDR blocks, by availability zone index, that won't route to any gateway."
  type        = list(string)
  default     = []
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the VPC and all its resources."
  type        = map(string)
  default     = {}
}
