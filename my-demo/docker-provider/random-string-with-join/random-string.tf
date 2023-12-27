#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
# Pulls the image
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "random_string" "random-name" {
  length           = 6
  special          = false
  upper = false
}
# output  for random string generated
output "random-name" {
  value = random_string.random-name.result
}
# Create a container with name using join & random string function
#refer join-function to know about join
resource "docker_container" "foo" {
  image = docker_image.nginx.image_id
  count = 2
  name  = join("-",["test",random_string.random-name.result])
  ports {
    internal = 80
    external = 82
  }
}
