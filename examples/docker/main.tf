data "docker_registry_image" "ubuntu" {
  name = "ubuntu:focal"
}

# resource "docker_network" "test" {
#   name = "test"
#   ipam_config {
#     subnet = "10.0.0.0/24"
#   }
# }

resource "docker_image" "ubuntu" {
  keep_locally  = true
  name          = data.docker_registry_image.ubuntu.name
  pull_triggers = [data.docker_registry_image.ubuntu.sha256_digest]
}

resource "docker_image" "ubuntu-ssh" {
  name = "ubuntu-ssh"
  build {
    path = "."
    tag  = ["ubntu-ssh:develop"]
  }
}

resource "docker_container" "ubuntu" {
  image    = resource.docker_image.ubuntu-ssh.name
  must_run = true
  name     = "ubuntu_container"
  rm       = true

  ports {
    external = 2222
    internal = 22
  }

  networks_advanced {
    name         = "test"
    ipv4_address = "10.0.0.100"
  }

}
