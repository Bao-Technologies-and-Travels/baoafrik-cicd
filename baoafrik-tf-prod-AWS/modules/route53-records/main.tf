resource "aws_route53_record" "prod_root" {
  zone_id = var.zone_id
  name    = var.prod_domain
  type    = "A"
  ttl = 300

  records = [var.prod_server_ip]
}

resource "aws_route53_record" "prod_www" {
  zone_id = var.zone_id
  name    = "www.${var.prod_domain}"
  type    = "A"
  ttl = 300

  records = [var.prod_server_ip]
}



resource "aws_route53_record" "jenkins" {
  zone_id = var.zone_id
  name    = "jenkins.${var.prod_domain}"
  type    = "A"
  ttl     = 300
  records = [var.prod_server_ip]
}