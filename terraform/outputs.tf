output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "efs_file_system_id" {
  description = "The ID of the EFS file system."
  value       = module.efs.file_system_id
}

output "efs_security_group_id" {
  description = "The ID of the security group for the EFS file system."
  value       = module.efs.security_group_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "dns_zone_id" {
  description = "The ID of the Route 53 hosted zone."
  value       = module.dns.zone_id
}


