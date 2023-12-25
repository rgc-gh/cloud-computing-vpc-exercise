variable "region" {
  description = "The selected AWS region"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = length(var.region) > 0 && can(regex("^[[:lower:]]+-[[:lower:]]+-[[:digit:]]$", var.region))
    error_message = "The region must be a valid AWS region. For example, 'us-east-1'."
  }
}

variable "cidr_block_spec" {
  description = "The IPv4 CIDR block base for all VPCs."
  type        = string
  default     = "10.%d.0.0/16"

  validation {
    condition     = can(regex("^(%d|25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(%d|25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(%d|25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(%d|25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/(1[0-6]|[0-9])$", var.cidr_block_spec))
    error_message = "The CIDR block specification must be in valid CIDR notation with a numeric placeholder. For example '10.%d.0.0/16'."
  }
}


variable "cidr_block_increment" {
  description = "The IPv4 CIDR block increment to add to each VPC."
  type        = number
  default     = 10

  validation {
    condition     = var.cidr_block_increment > 0
    error_message = "The CIDR block increment must be bigger than 0."
  }
}

variable "public_key_path" {
  description = "The path to the public key to connect via SSH to the EC2 instances"
  type        = string

  validation {
    condition     = length(var.public_key_path) > 0
    error_message = "The public key path cannot be empty."
  }
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

  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/(3[0-2]|[12]?[0-9])$", var.inbound_cidr_block))
    error_message = "The inbound CIDR block must be in valid CIDR notation. For example '0.0.0.0/0'."
  }
}
