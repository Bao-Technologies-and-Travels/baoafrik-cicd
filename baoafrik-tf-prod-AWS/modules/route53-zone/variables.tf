variable "prod_domain" {
  description = "Root domain name"
  type        = string
}

variable "zone_id" {
  description = "The ID of the hosted zone"
  type        = string
}

variable "prod_alb_dns" {
  type = string
}

variable "prod_alb_zone_id" {
  type = string
}
