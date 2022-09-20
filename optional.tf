variable "name" {
  description = "Name of the API"
  default     = null
  type        = string
}

variable "domain_name" {
  description = "Domain name for the API"
  default     = null
  type        = string
}

variable "alternate_domain_name" {
  description = "Alternate domain name for the API for which a DNS record will not be created. This can be useful for APIs that need to have CNAMEs defined in external accounts."
  default     = null
  type        = string
}

variable "primary_hosted_zone" {
  description = "Primary hosted zone for the API. e.g. example.org"
  default     = null
  type        = string
}

variable "protocol_type" {
  description = "Protocol type. Can be HTTP and WEBSOCKET"
  default     = "HTTP"
  type        = string
}

variable "endpoint_type" {
  description = "Endpoint type. Leave this REGIONAL"
  default     = "REGIONAL"
  type        = string
}

variable "security_policy" {
  description = "TLS version. Leave this TLS_1_2"
  default     = "TLS_1_2"
  type        = string
}

variable "stage_name" {
  description = "Name of the stage"
  default     = "$default"
  type        = string
}

variable "auto_deploy" {
  description = "Auto deploy API Gateway updates. Leave this true"
  default     = "true"
  type        = string
}

variable "integration_type" {
  description = "Integration type. Leave this AWS_PROXY"
  default     = "AWS_PROXY"
  type        = string
}

variable "connection_type" {
  description = "Connection type for the integeration endpoint. Probably want this to be INTERNET"
  default     = "INTERNET"
  type        = string
}

variable "integration_description" {
  description = "Integration description. Auto-generated off local.name if null"
  default     = null
  type        = string
}

variable "integration_method" {
  description = "Integration method. Leave this POST"
  default     = "POST"
  type        = string
}

variable "route_key" {
  description = "Route key. Leave this $default"
  default     = "$default"
  type        = string
}

variable "create_dns" {
  description = "Whether or not to provision a CNAME pointing to this API. domain_name returns API integration target, which requires separate CNAME if false."
  default     = true
  type        = bool
}

variable "acm_arn" {
  description = "ARN of the ACM certificate for the API integration"
  default     = null
  type        = string
}

variable "cors_configuration" {
  description = "CORS configuration map"
  default     = null
  type        = any
}

variable "dns_evaluate_target_health" {
  description = "(optional) evaluate health of endpoints by querying DNS records"
  default     = false
  type        = bool
}

variable "disable_execute_api_endpoint" {
  description = "(optional) disable default execute endpoint"
  default     = true
  type        = bool
}

variable "payload_format_version" {
  description = "(optional) payload format version"
  default     = "1.0"
  type        = string
}

variable "throttling_burst_limit" {
  description = "(optional) throttling burst limit"
  default     = 5000
  type        = number
}

variable "throttling_rate_limit" {
  description = "(optional) throttling rate limit"
  default     = 10000
  type        = number
}
