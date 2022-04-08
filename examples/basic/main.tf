module "lambda_api" {
  source = "../.."

  handler  = "main"
  filename = "../artifacts/handler.zip"
  runtime  = "go1.x"

  primary_hosted_zone = var.primary_hosted_zone

  environment  = var.environment
  product      = var.product
  repo         = var.repo
  organization = var.organization
}
