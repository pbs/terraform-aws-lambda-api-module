resource "aws_apigatewayv2_api" "api" {
  name                         = local.name
  protocol_type                = var.protocol_type
  disable_execute_api_endpoint = var.disable_execute_api_endpoint

  dynamic "cors_configuration" {
    for_each = local.cors_configuration
    content {
      allow_credentials = lookup(cors_configuration.value, "allow_credentials", null)
      allow_headers     = lookup(cors_configuration.value, "allow_headers", null)
      allow_methods     = lookup(cors_configuration.value, "allow_methods", null)
      allow_origins     = lookup(cors_configuration.value, "allow_origins", null)
      expose_headers    = lookup(cors_configuration.value, "expose_headers", null)
      max_age           = lookup(cors_configuration.value, "max_age", null)
    }
  }

  tags = local.tags
}

resource "aws_apigatewayv2_domain_name" "domain_name" {
  domain_name = local.domain_name
  domain_name_configuration {
    certificate_arn = local.certificate_arn
    endpoint_type   = var.endpoint_type
    security_policy = var.security_policy
  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name} Domain Name"
    }
  )
}

resource "aws_apigatewayv2_domain_name" "alternate_domain_name" {
  count = local.create_alternate_domain_name ? 1 : 0

  domain_name = var.alternate_domain_name
  domain_name_configuration {
    certificate_arn = local.certificate_arn
    endpoint_type   = var.endpoint_type
    security_policy = var.security_policy
  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name} Alternate Domain Name"
    }
  )
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.stage_name
  auto_deploy = var.auto_deploy

  default_route_settings {
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit  = var.throttling_rate_limit
  }

  tags = merge(
    local.tags,
    {
      Name = "${local.name} Stage"
    }
  )
}

resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.api.id
  domain_name = aws_apigatewayv2_domain_name.domain_name.id
  stage       = aws_apigatewayv2_stage.stage.id
}

resource "aws_apigatewayv2_api_mapping" "alternate_domain_api_mapping" {
  count = local.create_alternate_domain_name ? 1 : 0

  api_id      = aws_apigatewayv2_api.api.id
  domain_name = aws_apigatewayv2_domain_name.alternate_domain_name[0].id
  stage       = aws_apigatewayv2_stage.stage.id
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = var.integration_type
  connection_type        = var.connection_type
  description            = local.integration_description
  integration_method     = var.integration_method
  integration_uri        = module.lambda.invoke_arn
  payload_format_version = var.payload_format_version
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}
