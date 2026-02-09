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

variable "server_instance_profile_name" {
  description = "Name of the IAM instance profile to attach to the EC2 instance"
  type        = string
}