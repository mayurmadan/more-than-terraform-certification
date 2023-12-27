resource "docker_image" "test" {
  name = "nginx:alpine"
}

#use count in random string 
resource "random_string" "random-name1" {
  length           = 6
  count = 2
  special          = false
  upper = false
}
#use join function with random-string with count function to use single random string multiple type
resource "docker_container" "test" {
  image = docker_image.test.image_id
  count = 2
  name  = join("-",["test",random_string.random-name1[count.index].result])
  ports {
    internal = 80
  }
}
