variable "vpc_name" {
  type = string
  default = "baoafrik-prod"
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidr" {
  type = list(string)
}
variable "private_subnet_cidr" {
  type = list(string)
}
variable "azs" {
  type    = list(string)
  default = []
}
