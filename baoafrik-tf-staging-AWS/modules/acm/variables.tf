variable "domain" { type = string }
variable "alt_names" {
  type        = list(string)
  description = "List of alternate domain name for this certificate"
  default     = []
}
variable "zone_id" { type = string }
variable "staging_domain" {
  type = string
}