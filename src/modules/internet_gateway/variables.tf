# Internet Gateway
variable "name_suffix" {
  description = "The Name tag suffix of the internet gateway."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to which the internet gateway will be added."
  type        = string
}

# Metadata
variable "tags" {
  description = "A map of tags to add to the internet gateway."
  type        = map(string)
  default     = {}
}
