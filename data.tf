data "aws_caller_identity" "current" {}
data "aws_acm_certificate" "wildcard" {
  count  = var.acm_arn == null ? 1 : 0
  domain = "*.${var.primary_hosted_zone}"
}

data "aws_route53_zone" "zone" {
  count = var.create_dns ? 1 : 0
  name  = var.primary_hosted_zone
}
