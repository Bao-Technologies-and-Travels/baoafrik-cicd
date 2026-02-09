variable "name" {}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}

variable "db_name" {
  default = "baoafrikdb"
}

variable "db_username" {}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 40
}
variable "multi_az" {
  default = false
}
variable "db_engine" {
  default = "postgres"
}

