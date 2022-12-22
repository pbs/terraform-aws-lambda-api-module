output "arn" {
  description = "ARN of the API Gateway"
  value       = aws_apigatewayv2_api.api.arn
}

output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.arn
}

output "lambda_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.name
}

output "domain_name" {
  description = "Domain name that the API can be accessed at. If create_dns, return the CNAME created for the API, otherwise return the api integration domain name. This is useful when creating a DNS record for the API is not desired."
  value       = var.create_dns ? aws_route53_record.record[0].fqdn : aws_apigatewayv2_domain_name.domain_name.domain_name_configuration[0].target_domain_name
}

output "alternate_domain_name" {
  description = "Alternate domain name that the API can be accessed at. Returns the CNAME record name that should be created externally for the API with value output as `alternate_domain_endpoint`. This is useful for APIs where the CNAME is defined in another account."
  value       = local.create_alternate_domain_name ? aws_apigatewayv2_domain_name.alternate_domain_name[0].domain_name : null
}

output "alternate_domain_endpoint" {
  description = "Alternate endpoint that the API can be accessed at if a CNAME corresponding to `alternate_domain_name` resolves to this endpoint. Only populated if `alternate_domain_name` is not null"
  value       = local.create_alternate_domain_name ? aws_apigatewayv2_domain_name.alternate_domain_name[0].domain_name_configuration[0].target_domain_name : null
}

output "sg" {
  description = "Security group of the lambda function if there is one"
  value       = module.lambda.sg
}
