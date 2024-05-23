variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "The number of private subnets to create"
  type        = number
  default     = 2
}
