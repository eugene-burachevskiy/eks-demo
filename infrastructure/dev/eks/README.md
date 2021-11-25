## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.28 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.28 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 17.20.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.11.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_key_pair.ec2_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_userdata"></a> [additional\_userdata](#input\_additional\_userdata) | Additional userdata to pass for worker nodes | `string` | `"echo \"Empty additional userdata. Nothing to provision.\"\n"` | no |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | Alowed CIDR to connect to K8S endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_awscli_profile"></a> [awscli\_profile](#input\_awscli\_profile) | Name of your ~/.aws/credentials profile | `string` | `"default"` | no |
| <a name="input_cluster_auto_iam"></a> [cluster\_auto\_iam](#input\_cluster\_auto\_iam) | Automatically create cluster Security Group | `bool` | `true` | no |
| <a name="input_cluster_auto_sg"></a> [cluster\_auto\_sg](#input\_cluster\_auto\_sg) | Automatically create cluster Security Group | `bool` | `true` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_cluster_endpoint_enable_private"></a> [cluster\_endpoint\_enable\_private](#input\_cluster\_endpoint\_enable\_private) | Enable private access to K8S endpoint | `bool` | `true` | no |
| <a name="input_cluster_endpoint_enable_public"></a> [cluster\_endpoint\_enable\_public](#input\_cluster\_endpoint\_enable\_public) | Enable public access to K8S endpoint | `bool` | `true` | no |
| <a name="input_cluster_iam_role"></a> [cluster\_iam\_role](#input\_cluster\_iam\_role) | Cluster IAM role | `string` | `""` | no |
| <a name="input_cluster_log_retention_period"></a> [cluster\_log\_retention\_period](#input\_cluster\_log\_retention\_period) | Number of days to retain cluster logs. Requires `cluster_enabled_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html | `number` | `30` | no |
| <a name="input_cluster_manual_sg_id"></a> [cluster\_manual\_sg\_id](#input\_cluster\_manual\_sg\_id) | In case var.cluster\_auto\_sg is false set security group ID for cluster here | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | K8S cluster name | `string` | `"demo-eks-cluster-dev"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Desired Kubernetes master version. If you do not specify a value, the latest available version is used | `string` | `"1.21"` | no |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | Additional AWS account numbers to add to the aws-auth configmap. See https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/basic/variables.tf | `list(string)` | `[]` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. See https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/basic/variables.tf | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::ACC_NUMBER:user/eugene_burachevskiy@company.com",<br>    "username": "eugene_burachevskiy@company.com"<br>  }<br>]</pre> | no |
| <a name="input_spot_max_size"></a> [spot\_max\_size](#input\_spot\_max\_size) | The maximum size of the spot AutoScaling Groups | `number` | `3` | no |
| <a name="input_spot_min_size"></a> [spot\_min\_size](#input\_spot\_min\_size) | The minimum size of the spot AutoScaling Group | `number` | `1` | no |
| <a name="input_spot_volume_size"></a> [spot\_volume\_size](#input\_spot\_volume\_size) | root volume size for spot instances | `number` | `30` | no |
| <a name="input_spot_volume_type"></a> [spot\_volume\_type](#input\_spot\_volume\_type) | root volume type for spot instances, can be 'standard', 'gp2', or 'io1' | `string` | `"gp2"` | no |
| <a name="input_spot_workloads_price"></a> [spot\_workloads\_price](#input\_spot\_workloads\_price) | Max bid price for spots | `string` | `"0.09"` | no |
| <a name="input_spot_workloads_type"></a> [spot\_workloads\_type](#input\_spot\_workloads\_type) | Set of instance types for spot 'workloads' group | `string` | `"m5a.large"` | no |
| <a name="input_update_kubeconfig"></a> [update\_kubeconfig](#input\_update\_kubeconfig) | Write kubeconfig into local.kube\_home | `bool` | `true` | no |
| <a name="input_worker_auto_iam"></a> [worker\_auto\_iam](#input\_worker\_auto\_iam) | Automatically create worker Security Group | `bool` | `true` | no |
| <a name="input_worker_auto_sg"></a> [worker\_auto\_sg](#input\_worker\_auto\_sg) | Automatically create worker Security Group | `bool` | `true` | no |
| <a name="input_worker_manual_sg_id"></a> [worker\_manual\_sg\_id](#input\_worker\_manual\_sg\_id) | In case var.worker\_auto\_sg is false set security group ID for workers here | `string` | `""` | no |
| <a name="input_worker_ssh_key"></a> [worker\_ssh\_key](#input\_worker\_ssh\_key) | ssh public key name for workers | `string` | `"eugene_burachevskiy@company.com"` | no |
| <a name="input_worker_ssh_key_content"></a> [worker\_ssh\_key\_content](#input\_worker\_ssh\_key\_content) | ssh public key content for workers | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGqEBr9D3Nf1rzi8m0GLXqOD0ruIcKmUjUPqWPGduza5BmSO4i0p1bi25OAYYRUlw0Q1DcT8gA52EY7UroL6s0H0FUp2LS8si+fIvMHKBNQs9yBKZG0nu9SJ+ZENXgoSr4+GY+AO44Wrfpa5IMBq0R2n+jpNJY9AbpAhQxh4wL0pEixeqCOeSt0FCspCDe9ufB9bJSE9kA1JSmHBQppAk8zgbJT1hMAXTOI7Gf0qRaHiG6yvwJWDd+CXbaCOQb1w94t0s2c2HvxeDdFL15ysP7FH/yvVz8tLkL6olfwKMf/eGSlQSHN757Ca5Aufn7/o6y9uw0QoFFsZ4/hn56B2xh"` | no |
| <a name="input_workers_instance_profile"></a> [workers\_instance\_profile](#input\_workers\_instance\_profile) | Custom IAM instance profile for worker nodes | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_arn"></a> [eks\_cluster\_arn](#output\_eks\_cluster\_arn) | EKS cluster Amazon Resource Name (ARN) |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | The endpoint for the Kubernetes API server |
| <a name="output_eks_cluster_iam_role_arn"></a> [eks\_cluster\_iam\_role\_arn](#output\_eks\_cluster\_iam\_role\_arn) | EKS cluster IAM role arn |
| <a name="output_eks_cluster_iam_role_name"></a> [eks\_cluster\_iam\_role\_name](#output\_eks\_cluster\_iam\_role\_name) | EKS cluster IAM role name |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | EKS cluster name |
| <a name="output_eks_cluster_identity_oidc_issuer"></a> [eks\_cluster\_identity\_oidc\_issuer](#output\_eks\_cluster\_identity\_oidc\_issuer) | The OIDC Identity issuer for the cluster |
| <a name="output_eks_cluster_oidc_provider_arn"></a> [eks\_cluster\_oidc\_provider\_arn](#output\_eks\_cluster\_oidc\_provider\_arn) | OIDC provider arn |
| <a name="output_eks_cluster_security_group_id"></a> [eks\_cluster\_security\_group\_id](#output\_eks\_cluster\_security\_group\_id) | ID of the EKS cluster Security Group |
| <a name="output_eks_cluster_version"></a> [eks\_cluster\_version](#output\_eks\_cluster\_version) | K8S version |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | Private subnet CIDRs |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | Public subnet CIDRs |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | VPC CIDR |
| <a name="output_workers_autoscaling_group_arn"></a> [workers\_autoscaling\_group\_arn](#output\_workers\_autoscaling\_group\_arn) | ARN of the AutoScaling Group |
| <a name="output_workers_autoscaling_group_name"></a> [workers\_autoscaling\_group\_name](#output\_workers\_autoscaling\_group\_name) | The AutoScaling Group name |
| <a name="output_workers_launch_template_arns"></a> [workers\_launch\_template\_arns](#output\_workers\_launch\_template\_arns) | ARN of the launch template |
| <a name="output_workers_launch_template_ids"></a> [workers\_launch\_template\_ids](#output\_workers\_launch\_template\_ids) | ID of the launch template |
| <a name="output_workers_security_group_id"></a> [workers\_security\_group\_id](#output\_workers\_security\_group\_id) | ID of the worker nodes Security Group |
