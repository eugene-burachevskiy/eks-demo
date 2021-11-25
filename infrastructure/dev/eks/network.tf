module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name = "eks-demo-dev"

  cidr = "10.100.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.100.1.0/24", "10.100.2.0/24"]
  public_subnets  = ["10.100.10.0/24", "10.100.20.0/24"]

  enable_ipv6 = false
  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true


  tags = {
    Project     = "DEMO"
  }

  vpc_tags = {
    Name = "eks-demo-dev"
  }
}