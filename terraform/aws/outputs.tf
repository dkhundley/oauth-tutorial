## OUTPUT BLOCKS
## -------------------------------------------------------------------------------------------------
# Outputting the domain that the client will need to call
output "cognito_domain" {
  value = "https://${aws_cognito_user_pool_domain.cognito_user_pool_domain.domain}.auth.${var.aws_region}.amazoncognito.com/oauth2/token"
}

# Outputting the Cognito app client ID
output "app_client_id" {
  value = aws_cognito_user_pool_client.cognito_client.id
}

# Outputting the Cognito app client secret (NOTE: This is a sensitive credential!!!)
output "app_client_secret" {
  value     = aws_cognito_user_pool_client.cognito_client.client_secret
  sensitive = true
}

# Outputting the Cognito resource server ID
output "resource_server_id" {
  value = aws_cognito_resource_server.cognito_resource_server.id
}

# Outputting the Cognito resource server identifier (used in OAuth scopes)
output "resource_server_identifier" {
  value = aws_cognito_resource_server.cognito_resource_server.identifier
}

