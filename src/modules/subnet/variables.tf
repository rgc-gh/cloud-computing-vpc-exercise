# Subnet
variable "name_suffix" {
  description = "The Name tag suffix of the subnet."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to which the subnet will be added."
  type        = string
}

variable "availability_zone" {
  description = "The subnet availability zone name."
  type        = string
}

variable "cidr_block" {
  description = "The subnet IPv4 CIDR block."
  type        = string
}

variable "with_nat_gateway" {
  description = "If set, the subnet will contain a NAT gateway."
  type        = bool
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "Indicates whether instances launched in this subnet receive a public IPv4 address"
  type        = bool
  default     = false
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the subnet and all its resources."
  type        = map(string)
  default     = {}
}
