
output "staging_url" {
  value = "https://staging.${var.prod_domain}"
}

output "route53_zone_id" {
  value = module.route53_zone.zone_id
}
