variable "aws_region" {
  default = "us-east-1"
}

variable "project" {
  default = "baoafrik"
}

variable "prod_domain" {
  description = "Root domain, e.g. baoafrik.com"
}

variable "azs" {
  type    = list(string)
  default = []
}

variable "vpc_cidr" {
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "backend_cpu" {
  default = 512
}

variable "backend_memory" {
  default = 1024
}

variable "backend_port" {
  default = 8000
}

variable "backend_desired_count" {
  default = 2
}

variable "backend_min_count" {
  default = 1
}
variable "backend_max_count" {
  default = 4
}

variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "prod_bucket" {
  type = string
}


variable "zone_id" {
  type = string
}

variable "server_role" {
  type = string
}

variable "jenkins_policy" {
  type = string
}

variable "backend_s3_policy" {
  type = string
}

variable "server_instance_profile" {
  type = string
}