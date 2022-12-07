locals {
  name                         = var.name != null ? var.name : var.product
  lambda_name                  = var.lambda_name != null ? var.lambda_name : local.name
  domain_name                  = var.domain_name != null ? var.domain_name : "${local.name}.${var.primary_hosted_zone}"
  integration_description      = var.integration_description != null ? var.integration_description : "${local.name} Lambda Integration"
  certificate_arn              = var.acm_arn != null ? var.acm_arn : data.aws_acm_certificate.wildcard[0].arn
  cors_configuration           = var.cors_configuration != null ? toset([var.cors_configuration]) : toset([])
  create_alternate_domain_name = var.alternate_domain_name != null

  creator = "terraform"

  defaulted_tags = merge(
    var.tags,
    {
      Name                                      = local.name
      "${var.organization}:billing:product"     = var.product
      "${var.organization}:billing:environment" = var.environment
      creator                                   = local.creator
      repo                                      = var.repo
    }
  )

  tags = merge({ for k, v in local.defaulted_tags : k => v if lookup(data.aws_default_tags.common_tags.tags, k, "") != v })
}

data "aws_default_tags" "common_tags" {}
