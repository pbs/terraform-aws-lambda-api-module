output "arn" {
  value = module.lambda_api.arn
}

output "domain_name" {
  value = module.lambda_api.domain_name
}

output "ecr_repo_url" {
  value = module.ecr.repo_url
}
