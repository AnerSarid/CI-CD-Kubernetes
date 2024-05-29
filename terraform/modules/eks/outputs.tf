output "cluster_id" {
  value = aws_eks_cluster.main.id
}

output "node_group_name" {
  description = "The name of the EKS node group"
  value       = aws_eks_node_group.main.node_group_name
}
