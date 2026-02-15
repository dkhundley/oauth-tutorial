## GENERAL VARIABLES
## -------------------------------------------------------------------------------------------------
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "my_prefix" {
  type    = string
  default = "my-example"
}

variable "cognito_domain_prefix" {
  type        = string
  default     = null
  description = "Optional explicit Cognito domain prefix. If null, a unique prefix is generated."
}