output "prod_url" {
  value = "https://${var.prod_domain}"
}

# output "prod_alb_dns" {
#   value = module.alb_prod.alb_dns_name
# }

# output "route53_zone_id" {
#   value = module.route53_zone.zone_id
# }
