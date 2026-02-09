resource "aws_route53_record" "staging" {
  zone_id = var.zone_id
  name    = "staging.${var.prod_domain}"
  type    = "A"
  ttl     = 300
  records = [var.staging_public_ip]
}

resource "aws_route53_record" "caa" {
  zone_id = var.zone_id
  name    = var.prod_domain
  type    = "CAA"
  ttl     = 300

  records = [
    "0 issue \"amazon.com\"",
    "0 issue \"letsencrypt.org\""
  ]
}

resource "aws_route53_record" "jenkins" {
  zone_id = var.zone_id
  name    = "jenkins.${var.staging_domain}"
  type    = "A"
  ttl     = 300

  records = [var.staging_public_ip]
}