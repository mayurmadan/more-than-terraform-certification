variable "env" {
  description = "select the envioroment in runtime"
}

variable "image" {
    type = map(any)
    description  = "images for diff enviroment passed using lookup function"
  default = {
    dev = "nginx:latest"
    prod = "nginx:alpine" 
  }
}
variable "ext_port" {
  type = map(any)
  description = "port depends on env"
  default = {
    dev = "80"
    prod = "81"
  }
}

locals {
  container_count = length(var.ext_port)
}

