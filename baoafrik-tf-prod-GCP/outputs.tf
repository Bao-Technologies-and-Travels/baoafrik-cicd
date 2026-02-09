output "prod_url" {
  value = "https://${var.prod_domain}"
}

output "prod_instance_ip" {
  value = module.compute_prod.external_ip
}

output "cloudsql_connection_name" {
  value = module.cloudsql.connection_name
}

output "prod_bucket_name" {
  value = module.storage.prod_bucket_name
}

output "dns_name_servers" {
  value = module.dns.name_servers
}