terraform {
  required_version = "~>1"
  # backend "local" {
  #   path = "./local.tfstate"
  # }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
