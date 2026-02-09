output "zone_id" {
  value = aws_route53_record.prod_root.zone_id
}

output "prod_record_name" {
  value       = aws_route53_record.prod_root.fqdn
  description = "FQDN for production root record"
}
