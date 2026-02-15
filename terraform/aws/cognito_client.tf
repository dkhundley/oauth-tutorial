## RESOURCE BLOCKS
## -------------------------------------------------------------------------------------------------
# Creating the Cognito app client that has appropriate access to this Cognito user pool instance
resource "aws_cognito_user_pool_client" "cognito_client" {
  name         = "${var.my_prefix}-client"
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id

  generate_secret = true

  # Setting up OAuth with the appropriate scopes
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes = [
    "${aws_cognito_resource_server.cognito_resource_server.identifier}/read",
    "${aws_cognito_resource_server.cognito_resource_server.identifier}/write",
  ]
}