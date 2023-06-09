data "terraform_remote_state" "aks"{
  backend = "azurerm"

  config = {
    resource_group_name  = "Terraform-State"
    storage_account_name = "terraformstateazure01"
    container_name       = "tfstate-aks"
    key                  = "terraform.tfstate"
  }
}

# Generate Password for AKS Admin SPN
resource "azuread_service_principal_password" "aks_spn_password" {
  service_principal_id = data.terraform_remote_state.aks.outputs.aks_admin_spn_id
  end_date_relative    = "876000h" # 100 Years
}


# Fetch AKS Cluster Details
data "azurerm_kubernetes_cluster" "credentials" {
  name                = data.terraform_remote_state.aks.outputs.aks_cluster_name
  resource_group_name = data.terraform_remote_state.aks.outputs.aks_resource_group_name
}

output "aks_host_endpoint" {
  value = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host  
  sensitive = true
}

# We'll need the Application Id of the Azure Kubernetes Service AAD Server.
data "azuread_service_principal" "aks_aad_server" {
  display_name = "Azure Kubernetes Service AAD Server"
}

output "aks_aad_server_application_id" {
  value = data.azuread_service_principal.aks_aad_server.application_id
}