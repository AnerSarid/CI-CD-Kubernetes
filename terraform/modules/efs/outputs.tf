output "file_system_id" {
  description = "The ID of the EFS file system."
  value       = aws_efs_file_system.this.id
}

output "security_group_id" {
  description = "The ID of the security group for the EFS file system."
  value       = aws_security_group.this.id
}
