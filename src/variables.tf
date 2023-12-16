variable "region" {
  description = "The selected AWS region for the VPC"
  type        = string
  default     = "us-east-1"
}

variable "vpc-public-cidr" {
  description = "The address range of the public VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc-private-cidr" {
  description = "The address range of the private VPC"
  type        = string
  default     = "10.10.0.0/16"
}
