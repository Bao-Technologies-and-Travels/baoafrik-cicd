output "prod_certificate_arn" {
  value = data.aws_acm_certificate.prod.arn
}
