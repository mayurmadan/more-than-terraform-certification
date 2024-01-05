variable "ext_port" {
  type = list(any)
  default = [1880, 1881, 1882, 1883, 1884]

#configuring anyone to avoid using port rather than we specifyed in list, so avoid this file in source code,
#instead put this in .gitignore and user will update the variable from .tfvars file ,i.e using this rule
  validation {
#https://developer.hashicorp.com/terraform/language/functions/max
    condition = min(var.ext_port...) >= 1880 && max(var.ext_port...) <=1884
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
}

#https://developer.hashicorp.com/terraform/language/functions/length
#here lenght is 2
locals {
  container_count = length(var.ext_port)
}

