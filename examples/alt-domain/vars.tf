variable "primary_hosted_zone" {
  type        = string
  description = "Primary hosted zone for this API. Populate `TF_VAR_primary_hosted_zone` before running any tests to have this value populated."
}

variable "alternate_domain_name" {
  type        = string
  description = "Alternate domain name for this API. Populate `TF_VAR_alternate_domain_name` before running any tests to have this value populated."
}
