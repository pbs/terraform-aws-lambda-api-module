module "lambda_api" {
  source = "../.."

  handler  = "main"
  filename = "../artifacts/handler.zip"
  runtime  = "go1.x"

  primary_hosted_zone = var.primary_hosted_zone

  cors_configuration = {
    allow_credentials = false
    allow_headers     = ["*"]
    allow_methods     = ["*"]
    allow_origins     = ["*"]
    expose_headers    = ["*"]
    max_age           = 300
  }

  environment  = var.environment
  product      = var.product
  repo         = var.repo
  organization = var.organization
}
