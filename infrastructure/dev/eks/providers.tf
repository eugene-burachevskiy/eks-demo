provider "aws" {
    region = local.region
    profile = var.awscli_profile
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

terraform {
    backend "s3" {
    encrypt        = false
    profile        = "default"
    bucket         = "tfstate-bucket"
    region         = "us-east-2"
    key            = "dev/eks/terraform.tfstate"
    }
}
