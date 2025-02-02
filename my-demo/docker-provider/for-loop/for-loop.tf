resource "docker_image" "test" {
  name = "nginx:alpine"
}

#use count in random string 
resource "random_string" "random-name1" {
  length           = 4
  count = 2
  special          = false
  upper = false
}
#use join function with random-string with count function to use single random string multiple type
resource "docker_container" "test" {
  image = docker_image.test.image_id
  count = 2
  name  = join("-", ["test",random_string.random-name1[count.index].result])
  ports {
    internal = 80
  }
}
#in console testing used
#[for i in [1,2,3] : i+1]
#[for i in docker_container.test[*] : join(":", [i.network_data[0].ip_address, i.ports[0].external])]


output "using-for-loop" {
  value = [for i in docker_container.test[*]: join(":", [i.network_data[0].ip_address, i.ports[0].external])]
}
