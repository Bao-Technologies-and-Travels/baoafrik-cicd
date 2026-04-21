resource "google_compute_instance" "staging" {
  name         = "${var.project}-instance"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20251218"
      size  = 30
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link

    access_config {}
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = ["allow-egress", "baoafrik-backend-vm", "http-server", "https-server"]

  lifecycle {
    ignore_changes = [
      network_interface[0].access_config[0].nat_ip,
      metadata,
    ]
  }
}
