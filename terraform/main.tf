provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

module "eks" {
  source          = "./modules/eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  cluster_name    = var.cluster_name
  node_instance_type = ["t3.medium"]
}

module "efs" {
  source            = "./modules/efs"
  creation_token    = var.efs_creation_token
  transition_to_ia  = var.efs_transition_to_ia
  tags              = var.efs_tags
  subnet_ids        = module.vpc.private_subnets
  vpc_id            = module.vpc.vpc_id
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  name              = var.project_name
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
  a_records   = var.route53_a_records
  cname_records = {
    "frontend" = {
      name    = "frontend.${var.domain_name}"
      ttl     = 300
      records = module.alb.dns_name
    }
    "backend" = {
      name    = "api.${var.domain_name}"
      ttl     = 300
      records = module.alb.dns_name
    }
    "jenkins" = {
      name    = "jenkins.${var.domain_name}"
      ttl     = 300      
      records = module.alb.dns_name
    }
    "sonarqube" = {
      name    = "sonarqube.${var.domain_name}"
      ttl     = 300
      records = module.alb.dns_name
    }
    "argocd" = {
      name    = "argocd.${var.domain_name}"
      ttl     = 300
      records = module.alb.dns_name
    }
  }
}

module "alb" {
  source           = "./modules/alb"
  name             = var.project_name
  public_subnets          = module.vpc.public_subnets
  vpc_id           = module.vpc.vpc_id
  eks_nodegroup_name = module.eks.node_group_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

