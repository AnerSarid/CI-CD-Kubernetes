region           = "eu-central-1"
cluster_name     = "develop-eks-project"
project_name      = "projecteks"
domain_name       = "anersarid.dev"

node_instance_type = "t3.medium"

# EFS Variables
efs_creation_token = "projecteks"
efs_transition_to_ia = "AFTER_30_DAYS"
efs_tags = {
  Name = "projecteks"
}

# Route 53 Variables
route53_a_records = {}

route53_cname_records = {
  "frontend" = {
    name    = "frontend.anersarid.dev"
    ttl     = 300
    records = ""
  }
  "backend" = {
    name    = "api.anersarid.dev"
    ttl     = 300
    records = ""
  }
  "jenkins" = {
    name    = "jenkins.anersarid.dev"
    ttl     = 300
    records = ""
  }
  "sonarqube" = {
    name    = "sonarqube.anersarid.dev"
    ttl     = 300
    records = ""
  }
  "argocd" = {
    name    = "argocd.anersarid.dev"
    ttl     = 300
    records = ""
  }
}
