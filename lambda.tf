module "lambda" {
  source = "github.com/pbs/terraform-aws-lambda-module?ref=1.3.32"

  # Required
  handler   = var.handler
  filename  = var.filename
  runtime   = var.runtime
  image_uri = var.image_uri

  # Optional
  name                  = local.lambda_name
  description           = var.lambda_description
  role_arn              = var.role_arn
  timeout               = var.timeout
  environment_vars      = var.environment_vars
  memory_size           = var.memory_size
  log_retention_in_days = var.log_retention_in_days
  publish               = var.publish
  policy_json           = var.policy_json
  layers                = var.layers
  tracing_config_mode   = var.tracing_config_mode
  use_prefix            = var.use_prefix
  architectures         = var.architectures
  file_system_config    = var.file_system_config
  vpc_id                = var.vpc_id
  add_vpc_config        = var.add_vpc_config
  security_group_id     = var.security_group_id
  subnets               = var.subnets
  package_type          = var.package_type

  permissions_boundary_arn                        = var.permissions_boundary_arn
  lambda_insights_extension_version               = var.lambda_insights_extension_version
  lambda_insights_extension_account_number        = var.lambda_insights_extension_account_number
  parameters_and_secrets_extension_version        = var.parameters_and_secrets_extension_version
  parameters_and_secrets_extension_account_number = var.parameters_and_secrets_extension_account_number
  app_config_extension_version                    = var.app_config_extension_version
  app_config_extension_account_number             = var.app_config_extension_account_number
  ssm_path                                        = var.ssm_path
  add_ssm_extension_layer                         = var.add_ssm_extension_layer
  add_app_config_extension_layer                  = var.add_app_config_extension_layer
  allow_app_config_access                         = var.allow_app_config_access

  # Tags
  environment  = var.environment
  product      = var.product
  repo         = var.repo
  organization = var.organization
}
