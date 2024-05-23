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

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

