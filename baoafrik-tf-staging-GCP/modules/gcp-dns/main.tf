# resource "data.google_dns_managed_zone" "prod" {
#   name        = "prod-zone"
#   dns_name    = "${var.prod_domain}."
#   description = "Public DNS zone for ${var.prod_domain}"
# }

data "google_dns_managed_zone" "prod" {
  name        = "prod-zone"
  project = var.project
}

resource "google_dns_record_set" "staging" {
  name         = "${var.staging_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = [var.staging_ip_address]
}

resource "google_dns_record_set" "jenkins" {
  name         = "jenkins.${var.staging_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = [var.jenkins_ip_address]
}

resource "google_dns_record_set" "caa" {
  name         = "${var.prod_domain}."
  type         = "CAA"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas = [
    "0 issue \"letsencrypt.org\"",
  ]
}

resource "google_dns_record_set" "www_prod" {
  name         = "www.${var.prod_domain}."
  type         = "CNAME"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = ["${var.prod_domain}."]
}

resource "google_dns_record_set" "www_staging" {
  name         = "www.staging.${var.prod_domain}."
  type         = "CNAME"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = ["staging.${var.prod_domain}."]
}
