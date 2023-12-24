variable "name_suffix" {
  description = "The Name tag suffix of the VPC peering connection."
  type        = string
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
}

variable "requester_vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "route_table_ids" {
  description = "The route table IDs to associate to a route by route index."
  type        = list(string)
}

variable "cidr_blocks" {
  description = "The CIDR blocks to associated to a route by route index."
  type        = list(string)
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the VPC peering connection."
  type        = map(string)
  default     = {}
}
