# Pulls the image
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

# Create a container
resource "docker_container" "foo" {
  image = docker_image.nginx.image_id
  name  = "tf-nginx"
  ports {
    internal = 80
    external = 82
  }
}
#output
output "container-ip" {
  value = docker_container.foo.network_data[0].ip_address
  
}
output "container_port"{
    value = docker_container.foo.ports[0].external
}

#https://developer.hashicorp.com/terraform/language/functions/join
#using join function
output "container_host" {
    value = join(":",[docker_container.foo.network_data[0].ip_address,docker_container.foo.ports[0].external]) 
}
