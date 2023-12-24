# Key Pairs
variable "public_key_path" {
  description = "The path to the public key to connect via SSH to the EC2 instance"
  type        = string
}

# Security Groups
variable "vpc_id" {
  description = "The ID of the VPC to which the security group will be added."
  type        = string
}

variable "inbound_cidr_block" {
  description = "CIDR block allowed for inbound connections to the EC2 instances."
  type        = string
  default     = "0.0.0.0/0"
}

# EC2 Instances
variable "name_suffix" {
  description = "The Name tag suffix of the EC2 instance."
  type        = string
}

variable "ami" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "The type of the EC2 instance."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the EC2 will be added."
  type        = string
}

variable "user_data" {
  description = "The user data to use when launching the EC2 instance."
  type        = string
  default     = null
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the EC2 and all its resources."
  type        = map(string)
  default     = {}
}
