resource "google_sql_database_instance" "postgres" {
  name             = var.db_name
  database_version = var.db_version
  region           = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]
  settings {
    tier      = var.tier
    edition   = var.edition
    disk_size = var.disk_size

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.private_network
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "app_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "app_user" {
  instance = google_sql_database_instance.postgres.name
  name     = var.db_username
  password = var.db_password
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.db_name}-priv-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.private_network
}

# Enable Service Networking API
resource "google_project_service" "servicenetworking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "sqladmin" {
  project = var.project_id
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"

  disable_on_destroy = false
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.servicenetworking]
}