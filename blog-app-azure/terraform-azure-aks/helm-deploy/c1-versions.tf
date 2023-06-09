# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.59.0" 
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
    time = {
      source = "hashicorp/time"
      version = "0.9.1"
    }     
  }

  backend "azurerm" {}

}

# Provider Block
provider "azurerm" {
 features {}          
}

provider "time" {
  # Configuration options
}

/*
// This will work if Local Accounts are not diabled
provider "helm" {
  kubernetes {
    host                   = module.aks.host
    client_certificate     = base64decode(module.aks.admin_client_certificate)
    client_key             = base64decode(module.aks.admin_client_key)
    cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
  }
}
*/

/*
// This will work if Local Accounts are not diabled
// "kube_admin_config" works only if local accounts are not disabled. (As it pulls "--admin" configs)
// "kube-config" will not work, because we have actived AAD integration. We must use "kubelogin".
provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
  }
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.cluster_ca_certificate)
  }
}
*/


provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)

    # Using kubelogin to get an AAD token for the cluster.
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command = "kubelogin"
      args = [
        "get-token",
        "--environment",
        "AzurePublicCloud",
        "--server-id",
        data.azuread_service_principal.aks_aad_server.application_id, # Application Id of the "Azure Kubernetes Service AAD Server".(Builtin SPN - Enterprise Application)
        "--client-id",
        data.terraform_remote_state.aks.outputs.aks_admin_spn_client_id, // Application Id of the Service Principal we'll create via terraform.
        "--client-secret",
        azuread_service_principal_password.aks_spn_password.value, // The Service Principal's secret.
        "-t",
        data.terraform_remote_state.aks.outputs.aks_tenant_id, // The AAD Tenant Id.
        "-l",
        "spn" // Login using a Service Principal..
      ]
    }
  }
}
