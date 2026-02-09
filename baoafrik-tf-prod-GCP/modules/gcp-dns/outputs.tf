output "name_servers" {
  value = data.google_dns_managed_zone.prod.name_servers
}