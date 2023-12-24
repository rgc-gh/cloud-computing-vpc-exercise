# NAT Gateway
variable "name_suffix" {
  description = "The Name tag suffix of the NAT gateway."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the NAT gateway will be added."
  type        = string
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the NAT gateway."
  type        = map(string)
  default     = {}
}
