## OUTPUT BLOCKS
## -------------------------------------------------------------------------------------------------
# Outputting the tenant ID
output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

# Outputting the API app client ID
output "api_app_client_id" {
  value = azuread_application.api_app_registration.client_id
}

# Outputting the API identifier URI
output "api_identifier_uri" {
  value = azuread_application.api_app_registration.identifier_uris
}

# Outputting the client app client ID
output "client_app_client_id" {
  value = azuread_application.client_app_registration.client_id
}

# Outputting theh client app client secret
output "client_secret" {
  value     = azuread_application_password.client_secret.value
  sensitive = true
}