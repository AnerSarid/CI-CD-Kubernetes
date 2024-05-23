variable "creation_token" {
  description = "A unique name (a maximum of 64 characters are allowed)"
  type        = string
}

variable "transition_to_ia" {
  description = "Specifies the lifecycle policy of the EFS"
  type        = string
  default     = "AFTER_30_DAYS"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs where EFS will be mounted"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks that are allowed to access the EFS"
  type        = list(string)
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}
