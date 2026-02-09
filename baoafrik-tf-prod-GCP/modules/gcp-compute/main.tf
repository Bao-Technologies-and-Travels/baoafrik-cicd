resource "google_compute_instance" "prod" {
  name         = "${var.project}-instance"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 20
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

}
