resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.vpc_name}-public"
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region != null ? var.region : null
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_subnetwork" "private" {
  name                     = "${var.vpc_name}-private"
  ip_cidr_range            = var.private_subnet_cidr
  region                   = var.region != null ? var.region : null
  network                  = google_compute_network.vpc.self_link
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_web" {
  name    = "${var.vpc_name}-allow-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "3000", "3001"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_db" {
  name    = "${var.vpc_name}-allow-db"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = [var.private_subnet_cidr]
  target_tags = ["cloud-sql"]
}

resource "google_compute_firewall" "allow_egress" {
  name    = "${var.vpc_name}-allow-egress"
  network = google_compute_network.vpc.name

  direction = "EGRESS"
  priority = 1000

  allow {
    protocol = "all"
  }

  target_tags = ["allow-egress"]
}