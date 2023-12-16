variable "region" {
  description = "The selected AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_count" {
  description = "The total number of VPCs"
  type        = number
  default     = 2
}

variable "cidr" {
  description = "VPC CIDR blocks"
  type = object({
    block_spec : string
    increment : number
  })
  default = {
    block_spec = "10.%d.0.0/16"
    increment  = 10
  }
}

variable "availability_zones_count" {
  type    = number
  default = 2
}

variable "subnets_count" {
  type    = number
  default = 2
}
