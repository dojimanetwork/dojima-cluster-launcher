module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = false
  

  cluster_addons = {
    coredns = {
      most_recent = true
      resolve_conflicts_on_update = "PRESERVE"
    }
    kube-proxy = {
      most_recent = true
      resolve_conflicts_on_update = "PRESERVE"
    }
    vpc-cni = {
      most_recent = true
      resolve_conflicts_on_update = "PRESERVE"
    }
    aws-ebs-csi-driver = {
      most_recent = true
      resolve_conflicts_on_update = "PRESERVE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  tags       = merge({ "Name" = var.cluster_name }, var.tags)

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.node_group_settings.instance_types
  }

  eks_managed_node_groups = {
    hermesnode = {
      min_size     = var.node_group_settings.min_capacity
      max_size     = var.node_group_settings.max_capacity
      desired_size = var.node_group_settings.desired_capacity

      instance_types = var.node_group_settings.instance_types
      capacity_type  = "ON_DEMAND"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }


  enable_irsa = true
  /* cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
  */
}
