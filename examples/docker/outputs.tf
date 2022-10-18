output "terraform_state" {
  description = "The path to the backend state file"
  value       = "${path.module}/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
}

output "hostnames" {
  description = "The hostnames to test"
  value       = [resource.docker_container.ubuntu.ip_address]
}
