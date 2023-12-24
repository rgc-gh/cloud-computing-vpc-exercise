# Security Groups
variable "vpc_id" {
  description = "The ID of the VPC to which the security group will be added."
  type        = string
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
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the EC2 and all its resources."
  type        = map(string)
  default     = {}
}
