module "ecr" {
  source = "github.com/pbs/terraform-aws-ecr-module?ref=0.3.0"

  // Just to make testing easier
  image_tag_mutability = "MUTABLE"

  force_delete = true

  environment  = var.environment
  product      = var.product
  repo         = var.repo
  organization = var.organization
}

module "lambda_api" {
  source = "../.."

  image_uri    = "${module.ecr.repo_url}:latest"
  package_type = "Image"

  architectures = ["arm64"]

  primary_hosted_zone = var.primary_hosted_zone

  environment  = var.environment
  product      = var.product
  repo         = var.repo
  organization = var.organization
}
