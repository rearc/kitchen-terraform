terraform {
  required_version = "~>1.2"
  # backend "local" {
  #   path = "./local.tfstate"
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
}
