output "arn" {
  value = module.lambda_api.arn
}

output "domain_name" {
  value = module.lambda_api.domain_name
}

output "alternate_domain_name" {
  value = module.lambda_api.alternate_domain_name
}

output "alternate_domain_endpoint" {
  value = module.lambda_api.alternate_domain_endpoint
}
