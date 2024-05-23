region           = "eu-central-1"
cluster_name     = "develop-eks-project"
project_name      = "projecteks"
node_instance_type = "t3.medium"
efs_creation_token = "projecteks"
efs_transition_to_ia = "AFTER_30_DAYS"
efs_tags = {
  Name = "projecteks"
}


