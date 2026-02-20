## RESOURCE BLOCKS
## -------------------------------------------------------------------------------------------------
# Definining the API app registration
resource "azuread_application" "api_app_registration" {

  # Setting the display name of the API app registration
  display_name = "${var.my_prefix}-api-app-registration"

  # Setting the identifier URI
  identifier_uris = ["api://${data.azuread_client_config.current.tenant_id}/${var.my_prefix}-api"]

  # Defining the "read" app role
  app_role {
    display_name         = "MyApi.Read"
    value                = "MyApi.Read"
    id                   = uuidv5("dns", "read-role-${data.azuread_client_config.current.tenant_id}")
    allowed_member_types = ["Application"]
    description          = "Read only access"
    enabled              = true
  }

  # Defining the "write" app role
  app_role {
    display_name         = "MyApi.Write"
    value                = "MyApi.Write"
    id                   = uuidv5("dns", "write-role-${data.azuread_client_config.current.tenant_id}")
    allowed_member_types = ["Application"]
    description          = "Write access"
    enabled              = true
  }

}



# Creating the Enterprise Application (Service Principal) for the API
resource "azuread_service_principal" "api_enterprise_application" {
  client_id = azuread_application.api_app_registration.client_id
}