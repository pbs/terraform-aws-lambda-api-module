variable "lambda_name" {
  description = "Name of the Lambda function"
  default     = null
  type        = string
}

variable "role_arn" {
  description = "ARN of the role to be used for this Lambda"
  default     = null
  type        = string
}

variable "timeout" {
  description = "Timeout in seconds of the Lambda"
  default     = 3
  type        = number
}

variable "environment_vars" {
  description = "Map of environment variables for the Lambda. If null, defaults to setting an SSM_PATH based on the environment and name of the function. Set to {} if you would like for there to be no environment variables present. This is important if you are creating a Lambda@Edge."
  default     = null
  type        = map(any)
}

variable "lambda_description" {
  description = "Description for this lambda function"
  default     = null
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  default     = 128
  type        = number
}

variable "log_retention_in_days" {
  description = "Number of days to retain CloudWatch Log entries"
  default     = 7
  type        = number
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version"
  default     = true
  type        = bool
}

variable "policy_json" {
  description = "Policy JSON. If null, default policy granting access to SSM and cloudwatch logs is used"
  default     = null
  type        = string
}

variable "permissions_boundary_arn" {
  description = "ARN of the permissions boundary to use on the role created for this lambda"
  default     = null
  type        = string
}

variable "layers" {
  description = "Lambda layers to apply to function. If null, a Lambda Layer extension is added by default."
  default     = null
  type        = list(string)
}

variable "lambda_insights_extension_version" {
  description = "Lambda layer version for the LambdaInsightsExtension layer"
  default     = null
  type        = number
}

variable "lambda_insights_extension_account_number" {
  description = "Account number for the LambdaInsightsExtension layer"
  default     = "580247275435"
  type        = string
}

variable "parameters_and_secrets_extension_version" {
  description = "Lambda layer version for the AWS-Parameters-and-Secrets-Lambda-Extension layer"
  default     = null
  type        = number
}

variable "parameters_and_secrets_extension_account_number" {
  description = "Account number for the AWS-Parameters-and-Secrets-Lambda-Extension layer"
  default     = "177933569100"
  type        = string
}

variable "app_config_extension_version" {
  description = "Lambda layer version for the AWS-AppConfig-Extension layer"
  default     = null
  type        = number
}

variable "app_config_extension_account_number" {
  description = "Account number for the AWS-AppConfig-Extension layer"
  default     = "027255383542"
  type        = string
}

variable "tracing_config_mode" {
  description = "Tracing config mode for X-Ray integration on Lambda"
  default     = "Active"
  type        = string
  validation {
    condition     = contains(["Active", "PassThrough", "Disabled"], var.tracing_config_mode)
    error_message = "Valid configurations for X-Ray tracing config are 'Active' and 'PassThrough'. Setting this value to 'Disabled' disables X-Ray tracing."
  }
}

variable "use_prefix" {
  description = "Use prefix for resources instead of explicitly defining whole name where possible"
  default     = true
  type        = bool
}

variable "architectures" {
  description = "Architectures to target for the Lambda function"
  default     = ["x86_64"]
  type        = list(string)
}

variable "file_system_config" {
  description = "File system configuration for the Lambda function"
  default     = null
  type        = map(any)
}

variable "vpc_id" {
  description = "VPC ID. If null, one will be looked up based on environment tag."
  default     = null
  type        = string
}

variable "add_vpc_config" {
  description = "Add VPC configuration to the Lambda function"
  default     = false
  type        = bool
}

variable "security_group_id" {
  description = "Security group ID. If null, one will be created."
  default     = null
  type        = string
}

variable "subnets" {
  description = "Subnets to use for the Lambda function. Ignored if add_vpc_config is false. If null, one will be looked up based on environment tag."
  default     = null
  type        = list(string)
}

variable "ssm_path" {
  description = "SSM path to use for environment variables. If null, defaults to /$${var.environment}/$${local.name}"
  default     = null
  type        = string
}

variable "add_ssm_extension_layer" {
  description = "Add the AWS-Parameters-and-Secrets-Lambda-Extension layer to the Lambda function. Ignored if layers is not null or if using the ARM runtime."
  default     = true
  type        = bool
}

variable "add_app_config_extension_layer" {
  description = "Add the AWS-AppConfig-Lambda-Extension layer to the Lambda function. Ignored if layers is not null or if runtime is not supported."
  default     = true
  type        = bool
}

variable "allow_app_config_access" {
  description = "Allow AppConfig access from the Lambda function. Ignored if `policy_json` or `role_arn` are set."
  default     = true
  type        = bool
}
