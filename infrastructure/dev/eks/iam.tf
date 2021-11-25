# Additional roles and policies for k8s workloads

resource "aws_iam_policy" "autoscaler" {
  name        = "k8s-cluster-autoscaler-policy"
  description = "Policy for cluster-autoscaler, it is assigned to workers nodegroup IAM role"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Resource": "*"
    }
  ]
  })
}
