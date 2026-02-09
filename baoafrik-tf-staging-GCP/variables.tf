variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "project" {
  description = "GCP project name"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
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

variable "dev_bucket_name" {
  type = string
}

variable "staging_bucket_name" {
  type = string
}

variable "prod_domain" {
  type = string
}

variable "staging_domain" {
  type = string
}
