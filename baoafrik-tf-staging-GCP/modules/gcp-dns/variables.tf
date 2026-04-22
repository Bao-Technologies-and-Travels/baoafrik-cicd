variable "prod_domain" {
  type = string
}

variable "staging_domain" {
  type = string
}

variable "staging_ip_address" {
  type = string
}

variable "jenkins_ip_address" {
  type = string
}

variable "blog_ip_address" {
  description = "IP address for the blog server"
  type        = string
}

variable "project" {
  type = string
}
