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

resource "docker_image" "test" {
  name = "nginx:alpine"
}
#variable-validate
#https://developer.hashicorp.com/terraform/language/values/variables
#https://developer.hashicorp.com/terraform/language/expressions/custom-conditions#input-variable-validation
variable "internal_port" {
  type    = number
  default = 811111

  validation {
    condition = var.internal_port <= 65535 && var.internal_port > 0
#    condition     = var.internal_port == 80
    error_message = "The default should be 80 ."
  }
}

#use count in random string
resource "random_string" "random-name1" {
  length  = 6
  count   = 2
  special = false
  upper   = false
}
#use join function with random-string with count function to use single random string multiple type
resource "docker_container" "test" {
  image = docker_image.test.image_id
  count = 1
  name  = join("-", ["test", random_string.random-name1[count.index].result])
  ports {
    internal = var.internal_port
  }
}

output "using-for-loop" {
  value = [for i in docker_container.test[*] : join(":", [i.network_data[0].ip_address, i.ports[0].external])]
}

output "container-name" {
  value = docker_container.test[0].name
}

