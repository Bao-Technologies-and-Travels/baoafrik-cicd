# resource "aws_acm_certificate" "cert" {
#   prod_domain               = var.domain
#   subject_alternative_names = var.alt_names
#   validation_method         = "DNS"
#   lifecycle { create_before_destroy = true }
# }

# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.cert.domain_validation_options :
#     dvo.prod_domain => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }

#   zone_id = var.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   ttl     = 60
#   records = [each.value.record]
# }

# resource "aws_acm_certificate_validation" "cert_validation" {
#   certificate_arn         = aws_acm_certificate.cert.arn
#   validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
# }