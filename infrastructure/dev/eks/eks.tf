locals {
  region = "us-east-2"
  eks_worker_ami_name_filter = "amazon-eks-node-${var.kubernetes_version}*"
  kube_home = pathexpand("~/.kube")
  kube_config = "${local.kube_home}/config"
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = var.worker_ssh_key
  public_key = var.worker_ssh_key_content
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "17.20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version
  vpc_id          = module.vpc.vpc_id
  subnets         = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  manage_cluster_iam_resources  = var.cluster_auto_iam
  manage_worker_iam_resources   = var.worker_auto_iam
  cluster_iam_role_name         = var.cluster_iam_role
  workers_additional_policies    = [aws_iam_policy.autoscaler.arn]

  cluster_endpoint_private_access       = var.cluster_endpoint_enable_private
  cluster_endpoint_public_access        = var.cluster_endpoint_enable_public
  cluster_endpoint_public_access_cidrs  = var.allowed_ips

  cluster_create_security_group   = var.cluster_auto_sg
  worker_create_security_group    = var.worker_auto_sg

  cluster_security_group_id       = var.cluster_manual_sg_id
  worker_security_group_id        = var.worker_manual_sg_id

  cluster_enabled_log_types       = var.cluster_enabled_log_types
  cluster_log_retention_in_days   = var.cluster_log_retention_period

  tags          = merge({ "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned" }, {"k8s.io/cluster-autoscaler/enabled" = "true"})

  map_users     = var.map_users
  map_accounts  = var.map_accounts
  map_roles     = var.map_roles
  
  write_kubeconfig    = var.update_kubeconfig
  kubeconfig_output_path  = "${local.kube_home}/"

  worker_ami_name_filter = local.eks_worker_ami_name_filter
  enable_irsa = false

  worker_groups = [ 
    {
      name                    = "workloads-spot"
      instance_type           = var.spot_workloads_type
      asg_desired_capacity    = var.spot_min_size
      asg_min_size            = var.spot_min_size
      asg_max_size            = var.spot_max_size
      subnets                 = module.vpc.private_subnets
      protect_from_scale_in   = false

      spot_price              = var.spot_workloads_price
      
      iam_instance_profile_name = var.workers_instance_profile
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
      public_ip               = true
      key_name                = aws_key_pair.ec2_ssh_key.key_name
      additional_userdata     = var.additional_userdata
      

      root_volume_type        = var.spot_volume_type
      root_volume_size        = var.spot_volume_size
      ebs_optimized           = true
    }
  ]
}
