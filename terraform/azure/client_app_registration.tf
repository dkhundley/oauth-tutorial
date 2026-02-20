## RESOURCE BLOCKS
## -------------------------------------------------------------------------------------------------
# Definining the client app registration
resource "azuread_application" "client_app_registration" {

  # Setting the display name of the API app registration
  display_name = "${var.my_prefix}-client-app-registration"

}



# Creating the Enterprise Application (Service Principal) for the client
resource "azuread_service_principal" "client_enterprise_application" {
  client_id = azuread_application.client_app_registration.client_id
}



# Defining the "Read" App Role assignment
resource "azuread_app_role_assignment" "client_read_access" {

  # Setting the read App Role ID
  app_role_id = azuread_service_principal.api_enterprise_application.app_role_ids["MyApi.Read"]

  # Setting the client's Enterprise Application ID
  principal_object_id = azuread_service_principal.client_enterprise_application.object_id

  # Setting the API's Enterprise Application object ID
  resource_object_id = azuread_service_principal.api_enterprise_application.object_id

}



# Defining the "Write" App Role assignment
resource "azuread_app_role_assignment" "client_write_access" {

  # Setting the read App Role ID
  app_role_id = azuread_service_principal.api_enterprise_application.app_role_ids["MyApi.Write"]

  # Setting the client's Enterprise Application ID
  principal_object_id = azuread_service_principal.client_enterprise_application.object_id

  # Setting the API's Enterprise Application object ID
  resource_object_id = azuread_service_principal.api_enterprise_application.object_id

}



# Creating the client's client secret
resource "azuread_application_password" "client_secret" {
  application_id = azuread_application.client_app_registration.id
  display_name   = "local-dev"
}