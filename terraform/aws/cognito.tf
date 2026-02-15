## DATA BLOCKS
## -------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

## RESOURCE BLOCKS
## -------------------------------------------------------------------------------------------------
# Setting up the Cognito user pool
resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${var.my_prefix}-user-pool"
}

# Setting up Cognito user pool domain
resource "aws_cognito_user_pool_domain" "cognito_user_pool_domain" {
  domain       = coalesce(var.cognito_domain_prefix, "${var.my_prefix}-${data.aws_caller_identity.current.account_id}-domain")
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
}

# Setting up the resource server for applying custom scopes
resource "aws_cognito_resource_server" "cognito_resource_server" {
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
  name         = "${var.my_prefix}-resource-server"
  identifier   = "my-api"

  # Setting the scopes
  scope {
    scope_name        = "read"
    scope_description = "Read access"
  }

  scope {
    scope_name        = "write"
    scope_description = "Write access"
  }
}