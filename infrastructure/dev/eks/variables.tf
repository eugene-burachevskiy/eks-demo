variable "awscli_profile" {
  description = "Name of your ~/.aws/credentials profile"
  type        = string
  default     = "default"
}

//////////////// EKS MODULE CLUSTER VARS

variable "cluster_name" {
  description = "K8S cluster name"
  type        = string
  default     = "demo-eks-cluster-dev"
}

variable "kubernetes_version" {
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
  type        = string
  default     = "1.21"
}

variable "cluster_endpoint_enable_private" {
  description = "Enable private access to K8S endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_enable_public" {
  description = "Enable public access to K8S endpoint"
  type        = bool
  default     = true
}

variable "allowed_ips" {
  type        = list(string)
  default     = [ "0.0.0.0/0" ]
  description = "Alowed CIDR to connect to K8S endpoint"
}

variable "cluster_iam_role" {
  description = "Cluster IAM role"
  type        = string
  #default     = "eksClusterRoleDefault"
  default     = ""
}

variable "cluster_auto_iam" {
  description = "Automatically create cluster IAM role"
  type        = bool
  default     = true
}

variable "worker_auto_iam" {
  description = "Automatically create worker IAM role"
  type        = bool
  default     = true
}

variable "cluster_auto_sg" {
  description = "Automatically create cluster Security Group"
  type        = bool
  default     = true
}

variable "worker_auto_sg" {
  description = "Automatically create worker Security Group"
  type        = bool
  default     = true
}

variable "cluster_manual_sg_id" {
  description = "In case var.cluster_auto_sg is false set security group ID for cluster here"
  type        = string
  #default     = "sg-0657fae5eba744283"
  default     = ""
}

variable "worker_manual_sg_id" {
  description = "In case var.worker_auto_sg is false set security group ID for workers here"
  type        = string
  #default     = "sg-0657fae5eba744283"
  default     = ""
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html "
  type        = list(string)
  default     = ["api","audit","authenticator","controllerManager","scheduler"]  
}

variable "cluster_log_retention_period" {
  description = "Number of days to retain cluster logs. Requires `cluster_enabled_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html "
  type        = number
  default     = 30
}

variable "update_kubeconfig" {
  description = "Write kubeconfig into local.kube_home"
  type        = bool
  default     = true
}
variable "worker_ssh_key" {
  type        = string
  default     = "eugene_burachevskiy@company.com"
  description = "ssh public key name for workers"
}

variable "worker_ssh_key_content" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGqEBr9D3Nf1rzi8m0GLXqOD0ruIcKmUjUPqWPGduza5BmSO4i0p1bi25OAYYRUlw0Q1DcT8gA52EY7UroL6s0H0FUp2LS8si+fIvMHKBNQs9yBKZG0nu9SJ+ZENXgoSr4+GY+AO44Wrfpa5IMBq0R2n+jpNJY9AbpAhQxh4wL0pEixeqCOeSt0FCspCDe9ufB9bJSE9kA1JSmHBQppAk8zgbJT1hMAXTOI7Gf0qRaHiG6yvwJWDd+CXbaCOQb1w94t0s2c2HvxeDdFL15ysP7FH/yvVz8tLkL6olfwKMf/eGSlQSHN757Ca5Aufn7/o6y9uw0QoFFsZ4/hn56B2xh"
  description = "ssh public key content for workers"
}


//////// EKS MODULE WORKERS VARS

variable "spot_min_size" {
  type        = number
  description = "The minimum size of the spot AutoScaling Group"
  default     = 1
}

variable "spot_max_size" {
  type        = number
  description = "The maximum size of the spot AutoScaling Groups"
  default     = 3
}

variable "spot_workloads_type" {
  type        = string
  description = "Set of instance types for spot 'workloads' group"
  default     = "m5a.large"
}

variable "spot_workloads_price" {
  type        = string
  description = "Max bid price for spots"
  default     = "0.09"
}

variable "spot_volume_type" {
  type        = string
  description = "root volume type for spot instances, can be 'standard', 'gp2', or 'io1'"
  default     = "gp2"
}

variable "spot_volume_size" {
  type        = number
  description = "root volume size for spot instances"
  default     = 30
}

variable "additional_userdata" {
  type        = string
  description = "Additional userdata to pass for worker nodes"
  default     = <<EOF
echo "Empty additional userdata. Nothing to provision."
EOF
}

variable "workers_instance_profile" {
  type        = string
  description = "Custom IAM instance profile for worker nodes"
  #default     = "orchestrator-default-ec2-profile"
  default     = ""
}


////////////////////// CLUSTER USERS/ROLES VARS

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap. See https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/basic/variables.tf"
  type        = list(string)
  default     = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap. See https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/basic/variables.tf"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::ACC_NUMBER:user/eugene_burachevskiy@company.com"
      username = "eugene_burachevskiy@company.com"
      groups   = ["system:masters"]
    }
  ]
  #default = []
}