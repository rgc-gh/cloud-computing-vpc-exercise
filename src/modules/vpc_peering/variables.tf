variable "name_suffix" {
  description = "The Name tag suffix of the VPC peering connection."
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "vpc_route_table_id" {
  description = "The route table ID of the requester VPC."
  type        = string
}

variable "peer_vpc_cidr_block" {
  description = "The CIDR block ID of the peer VPC."
  type        = string
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the VPC peering connection."
  type        = map(string)
  default     = {}
}
