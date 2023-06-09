/*
locals {
  external_dns_sa_name = "external-dns-sa"
}
*/

# Public DNS Zone
data "azurerm_dns_zone" "public_dns_zone" {
  name                = var.public_domain_name
  resource_group_name = var.public_domain_rg
}

output "dns_zone_id" {
  value = data.azurerm_dns_zone.public_dns_zone.id
}

# Public DNS Zone RG
data "azurerm_resource_group" "public_dns_zone_rg" {
  name = var.public_domain_rg
}

output "dns_zone_rg_id" {
  value = data.azurerm_resource_group.public_dns_zone_rg.id
}

/* Did not work with new Managed Identity. Using existing AKS Kubelet Managed Identity
# Managed Identity
resource "azurerm_user_assigned_identity" "external_dns_mi" {
  location            = data.terraform_remote_state.aks.outputs.aks_resource_group_location
  name                = var.aks_external_dns_mi_name
  resource_group_name = data.terraform_remote_state.aks.outputs.aks_resource_group_name
}


output "aks_external_dns_mi_principal_id" {
  value = azurerm_user_assigned_identity.external_dns_mi.principal_id
}

output "aks_external_dns_mi_client_id" {
  value = azurerm_user_assigned_identity.external_dns_mi.client_id
}
*/

# Read access to Public DNS Zone RG - Kubelet MI
resource "azurerm_role_assignment" "public_dns_zone_rg" {
  scope                = data.azurerm_resource_group.public_dns_zone_rg.id
  role_definition_name = "Reader"
  principal_id         = data.terraform_remote_state.aks.outputs.aks_kubelet_managed_identity_principal_id
}

# Contributor access to Public DNS Zone - Kubelet MI
resource "azurerm_role_assignment" "public_dns_zone" {
  scope                = data.azurerm_dns_zone.public_dns_zone.id
  role_definition_name = "Contributor"
  principal_id         = data.terraform_remote_state.aks.outputs.aks_kubelet_managed_identity_principal_id
}

/*
# OIDC Configuration - Federated Identity (Mapping k8s Service Account to Azure Managed Identity)
# Did not work with new Managed Identity. Using existing AKS Kubelet Managed Identity
resource "azurerm_federated_identity_credential" "aks_external_dns_oidc" {

  name                = "aks_external_dns_oidc"
  resource_group_name = data.terraform_remote_state.aks.outputs.aks_resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = data.terraform_remote_state.aks.outputs.aks_oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.external_dns_mi.id
  subject             = format("system:serviceaccount:%s:%s", var.external_dns_namespace, local.external_dns_sa_name)
}
*/

# External DNS Helm Release
resource "helm_release" "external_dns" {
  
  depends_on = [
    azurerm_role_assignment.public_dns_zone_rg,
    azurerm_role_assignment.public_dns_zone
  ]
  
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  
  namespace = var.external_dns_namespace
  create_namespace = true

  values = [
    "${file("${path.module}/config-files/external-dns-labels-annotations.yml")}"
  ]

  set {
    name  = "txtOwnerId"
    value = "${data.terraform_remote_state.aks.outputs.aks_cluster_name}"
  }
  set {
    name  = "domainFilters[0]"
    value = "${var.public_domain_name}"
  }
  set {
    name  = "provider"
    value = "azure"
  }
  set {
    name  = "azure.resourceGroup"
    value = "${var.public_domain_rg}"
  }
  set {
    name  = "azure.cloud"
    value = "AzurePublicCloud"
  }
  set {
    name  = "policy"
    value = "sync"
  }

  atomic = true
  wait = true
  
}
