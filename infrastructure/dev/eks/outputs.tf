output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  value       = module.vpc.private_subnets_cidr_blocks
}


output "eks_cluster_id" {
  description = "EKS cluster name"
  value       = module.eks.cluster_id
}

output "eks_cluster_version" {
  description = "K8S version"
  value       = module.eks.cluster_version
}

output "eks_cluster_arn" {
  description = "EKS cluster Amazon Resource Name (ARN)"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the Kubernetes API server"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_identity_oidc_issuer" {
  description = "The OIDC Identity issuer for the cluster"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_oidc_provider_arn" {
  description = "OIDC provider arn"
  value       = module.eks.oidc_provider_arn
}

output "eks_cluster_security_group_id" {
  description = "ID of the EKS cluster Security Group"
  value       = module.eks.cluster_security_group_id
}

output "eks_cluster_iam_role_name" {
  description = "EKS cluster IAM role name"
  value       = module.eks.cluster_iam_role_name
}

output "eks_cluster_iam_role_arn" {
  description = "EKS cluster IAM role arn"
  value       = module.eks.cluster_iam_role_arn
}

output "workers_launch_template_ids" {
  description = "ID of the launch template"
  value       = module.eks.workers_launch_template_ids
}

output "workers_launch_template_arns" {
  description = "ARN of the launch template"
  value       = module.eks.workers_launch_template_arns
}

output "workers_autoscaling_group_name" {
  description = "The AutoScaling Group name"
  value       = module.eks.workers_asg_names
}

output "workers_autoscaling_group_arn" {
  description = "ARN of the AutoScaling Group"
  value       = module.eks.workers_asg_arns
}

output "workers_security_group_id" {
  description = "ID of the worker nodes Security Group"
  value       = module.eks.worker_security_group_id
}