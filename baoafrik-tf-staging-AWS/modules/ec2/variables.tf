variable "name" {}
variable "ami" {
  type = string
}
variable "instance_type" {}
variable "subnet_id" {
  type = string
}
variable "vpc_id" {}
variable "associate_public_ip" {
  default = true
}
variable "open_port" {
  default = 80
}
variable "key_name" {}
variable "sg_ids" {
  type = list(string)
}
variable "iam_instance_profile" {
  type        = string
  description = "IAM instance proile to attach to EC2"
  default     = null
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
}