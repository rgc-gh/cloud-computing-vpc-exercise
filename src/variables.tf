variable "region" {
  description = "The selected AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cidr_block_spec" {
  description = "The IPv4 CIDR block base for all VPCs."
  type        = string
  default     = "10.%d.0.0/16"
}


variable "cidr_block_increment" {
  description = "The IPv4 CIDR block increment to add to each VPC."
  type        = number
  default     = 10
}
