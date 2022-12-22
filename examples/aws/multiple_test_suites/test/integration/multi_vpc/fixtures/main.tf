terraform {
  required_version = "~>1.3.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  # region     = var.region
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
}

module "test" {
  source = "../../../../"

  vpcs = [
    {
      name               = "kitchen-terraform-01"
      cidr               = "10.0.0.0/16"
      azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
      private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
      enable_ipv6        = false
      enable_nat_gateway = false
      single_nat_gateway = true
      tags = {
        Terraform = "True"
        Kitchen   = "True"
        Workspace = terraform.workspace
      }
    },
    {
      name               = "kitchen-terraform-02"
      cidr               = "10.1.0.0/16"
      azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
      private_subnets    = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
      public_subnets     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
      enable_ipv6        = false
      enable_nat_gateway = false
      single_nat_gateway = true
      tags = {
        Terraform = "True"
        Kitchen   = "True"
        Workspace = terraform.workspace
      }
    }
  ]
}

output "terraform_workspace" {
  value = terraform.workspace
}

output "terraform_state" {
  description = "The path to the backend state file"
  value       = "${path.module}/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
}

output "region" { value = "us-west-2" }

output "vpcs" {
  value = module.test.vpc
}
