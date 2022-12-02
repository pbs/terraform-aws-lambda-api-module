# These are required for zip file based lambdas
variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = null
}

variable "filename" {
  description = "Filename for the artifact to use for the Lambda"
  type        = string
  default     = null
}

variable "runtime" {
  description = "Runtime for the lambda function"
  type        = string
  default     = null
}

# This is required for container based lambdas

variable "image_uri" {
  description = "URI of the container image to use for the Lambda"
  type        = string
  default     = null
}
