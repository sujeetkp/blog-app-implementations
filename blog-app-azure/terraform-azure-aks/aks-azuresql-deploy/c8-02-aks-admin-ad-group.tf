
# Current SPN Details
data "azuread_client_config" "current" {}

# This SPN will be used to deploy helm charts in k8s cluster
resource "azuread_application" "aks_admin_app" {
  display_name    = var.aks_admin_spn
}

resource "azuread_service_principal" "aks_admin_spn" {
  application_id = azuread_application.aks_admin_app.application_id
}

resource "azuread_group" "aks_cluster_admins" {
  display_name     = var.aks_azuread_admin_group
  description      = "Used to manage Azure Kubernetes Admins"
  security_enabled = true
  #assignable_to_role = true

  owners           = [data.azuread_client_config.current.object_id]

  members = [
    data.azuread_client_config.current.object_id,
    azuread_service_principal.aks_admin_spn.object_id,
  ]

}

output "aks_admin_spn_client_id" {
  value = azuread_application.aks_admin_app.application_id
}

output "aks_admin_spn_id" {
  value = azuread_service_principal.aks_admin_spn.id
}

output "aks_tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}