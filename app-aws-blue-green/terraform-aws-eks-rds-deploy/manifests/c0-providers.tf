terraform {
  required_version = ">1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.1.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.0"
    }
    tls = {
      version = "4.0.4"
    }
  }

  #Configuration To be picked from Config file
  backend "s3" {}
  
}

provider "aws" {
  region = var.aws_region
}


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}


provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}
