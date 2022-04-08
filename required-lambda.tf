variable "handler" {
  description = "Lambda handler"
  type        = string
}

variable "filename" {
  description = "Filename for the artifact to use for the Lambda"
  type        = string
}

variable "runtime" {
  description = "Runtime for the lambda function"
  type        = string
}
