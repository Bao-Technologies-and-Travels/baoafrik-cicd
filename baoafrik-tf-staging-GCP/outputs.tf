output "staging_url" {
  value = "https://staging.${var.prod_domain}"
}

output "staging_instance_ip" {
  value = module.compute_staging.external_ip
}

output "cloudsql_connection_name" {
  value = module.cloudsql.connection_name
}

output "staging_bucket_name" {
  value = module.storage.staging_bucket_name
}

output "dev_bucket_name" {
  value = module.storage.dev_bucket_name
}

output "dns_name_servers" {
  value = module.dns.name_servers
}