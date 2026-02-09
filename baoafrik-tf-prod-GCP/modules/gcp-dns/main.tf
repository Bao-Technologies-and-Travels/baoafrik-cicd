data "google_dns_managed_zone" "prod" {
  name        = "prod-zone"
  project = var.staging_project
}

resource "google_dns_record_set" "prod" {
  name         = "${var.prod_domain}."
  project = var.staging_project
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = [var.prod_ip_address]
}

resource "google_dns_record_set" "jenkins" {
  name         = "jenkins.${var.prod_domain}."
  project = var.staging_project
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas      = [var.jenkins_ip_address]
}

resource "google_dns_record_set" "caa" {
  name         = "${var.prod_domain}."
  project = var.staging_project
  type         = "CAA"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.prod.name
  rrdatas = [
    "0 issue \"letsencrypt.org\"",
  ]
}