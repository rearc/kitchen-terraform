output "terraform_workspace" {
  value = terraform.workspace
}

output "terraform_state" {
  description = "The path to the backend state file"
  value       = "${path.module}/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
}
output "region" {
  value = var.region
}

output "vpcs" {
  value = module.test.vpc
}
