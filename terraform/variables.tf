variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Project name for naming resources"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_instance_type" {
  description = "Instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "efs_creation_token" {
  description = "A unique name (a maximum of 64 characters are allowed)"
  type        = string
  default     = "projecteks"
}

variable "efs_transition_to_ia" {
  description = "Specifies the lifecycle policy of the EFS"
  type        = string
  default     = "AFTER_30_DAYS"
}

variable "efs_tags" {
  description = "A mapping of tags to assign to the EFS"
  type        = map(string)
  default     = {
    Name = "projecteks"
  }
}

variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

# Route 53 Variables
variable "route53_a_records" {
  description = "A map of A DNS records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "route53_cname_records" {
  description = "A map of CNAME DNS records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = string
  }))
  default = {}
}


