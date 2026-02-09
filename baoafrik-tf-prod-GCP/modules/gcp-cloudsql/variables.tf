variable "project" {
  type = string
}

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_network" {
  description = "VPC network self link"
  type        = string
}

variable "db_version" {
  type    = string
  default = "POSTGRES_17"
}

variable "tier" {
  type    = string
  default = "db-custom-1-3840" # 1 vCPU, 3.75GB RAM - Cost-optimized for production
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "edition" {
  type    = string
  default = "ENTERPRISE"
}
