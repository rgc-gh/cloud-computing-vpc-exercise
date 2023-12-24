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

variable "public_key_path" {
  description = "The path to the public key to connect via SSH to the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "inbound_cidr_block" {
  description = "CIDR block allowed for inbound connections to the EC2 instances."
  type        = string
  default     = "0.0.0.0/0"
}
