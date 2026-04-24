output "external_ip" {
  value = google_compute_instance.prod.network_interface[0].access_config[0].nat_ip
}

output "blog_external_ip" {
  value = google_compute_instance.blog.network_interface[0].access_config[0].nat_ip
}

output "blog_private_ip" {
  value = google_compute_instance.blog.network_interface[0].network_ip
}
