resource "aws_efs_file_system" "this" {
  creation_token = var.creation_token
  lifecycle_policy {
    transition_to_ia = var.transition_to_ia
  }
  tags = var.tags
}

resource "aws_efs_mount_target" "this" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = element(var.subnet_ids, count.index)
  security_groups = [aws_security_group.this.id]
}

resource "aws_security_group" "this" {
  name        = "${var.name}-efs-sg"
  description = "Allow NFS traffic to EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}