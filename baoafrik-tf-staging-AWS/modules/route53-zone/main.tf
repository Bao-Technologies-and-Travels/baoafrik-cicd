data "aws_route53_zone" "zone" {
  name         = var.prod_domain
  private_zone = false
}