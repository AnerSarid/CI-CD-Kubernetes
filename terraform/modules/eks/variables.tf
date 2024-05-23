variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_instance_type" {
  description = "Type of EC2 instance to use for the node group"
  type        = list(string)
  default     = ["t3.medium"]  # Example default value
}
