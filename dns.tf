resource "aws_route53_record" "record" {
  count   = var.create_dns ? 1 : 0
  name    = aws_apigatewayv2_domain_name.domain_name.domain_name
  zone_id = data.aws_route53_zone.zone[0].zone_id
  type    = "A"
  alias {
    name                   = aws_apigatewayv2_domain_name.domain_name.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.domain_name.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = var.dns_evaluate_target_health
  }
}
