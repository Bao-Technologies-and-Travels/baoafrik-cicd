variable "zone_id" {
  description = "ID of the hosted zone"
  type        = string
}

variable "prod_domain" {
  description = "Root domain name (e.g., baoafrik.com)"
  type        = string
}

variable "prod_server_ip" {
  description = "Public IP address of the prod EC2 instance"
  type        = string
}