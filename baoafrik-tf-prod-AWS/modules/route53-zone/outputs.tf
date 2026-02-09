output "zone_id" {
  value = data.aws_route53_zone.zone.id
}

output "name_servers" {
  value = data.aws_route53_zone.zone.name_servers
}
