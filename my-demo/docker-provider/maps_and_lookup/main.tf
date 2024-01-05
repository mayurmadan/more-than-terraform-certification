terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

#################################
#tested on console using 
#> lookup (var.image,"dev")
#"nginx:latest"
#> lookup (var.image,"prod")
#"nginx:alpine"
##################################

resource "docker_image" "nodered_image" {
  name = lookup(var.image, var.env)
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}


resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.name
  ports {
    internal = "80"
    external = lookup(var.ext_port,var.env)
  }
}
