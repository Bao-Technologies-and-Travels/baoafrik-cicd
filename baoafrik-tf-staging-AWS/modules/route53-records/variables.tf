variable "zone_id" {
  description = "ID of the hosted zone"
  type        = string
}

variable "prod_domain" {
  description = "Root domain name"
  type        = string
}

variable "staging_domain" {
  description = "Root domain name"
  type        = string
}

variable "staging_public_ip" {
  description = "Public IP address of the staging EC2 instance"
  type        = string
}