variable "project" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "network_self_link" {
  type = string
}

variable "subnet_self_link" {
  type = string
}

variable "service_account_email" {
  type = string
}

variable "blog_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "blog_disk_size" {
  type    = number
  default = 10
}
