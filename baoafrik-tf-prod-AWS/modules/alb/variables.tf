variable "name" {}
variable "vpc_id" {}
variable "public_subnets" { type = list(string) }
variable "public_subnet_id" {}
variable "prod_certificate_arn" {
  type = string
}

variable "target_port" {
  type    = number
  default = 80
}
variable "health_check_path" {
  default = "/"
}
