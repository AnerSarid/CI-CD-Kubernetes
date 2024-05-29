variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "eks_nodegroup_name" {
  description = "The name of the EKS node group to register with the ALB target group"
  type        = string
}

variable "name" {
  description = "The name of the ALB"
  type        = string
}
