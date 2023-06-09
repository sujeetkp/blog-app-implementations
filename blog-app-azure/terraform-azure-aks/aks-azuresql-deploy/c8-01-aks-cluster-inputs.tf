# AKS Variables
variable "aks_cluster_name" {
  description = "Azure Kubernetes Cluster name"
  type = string
}

variable "aks_azuread_admin_group" {
  description = "Azure Kubernetes Admin AD Group"
  type = string
}

variable "aks_cluster_version" {
  description = "Azure Kubernetes Cluster Version"
  type = string
  default = "dev"
}

variable "aks_network_plugin" {
  description = "Azure Kubernetes Network Plugin (azure/kubenet)"
  type = string
}

/*
variable "aks_network_policy" {
  description = "Azure Kubernetes Network Policy"
  type = string
}
*/

variable "aks_enable_azure_policy" {
  description = "Azure Kubernetes Enable Azure Policy(For AzureCNI)"
  type = bool
}

variable "aks_node_os_disk_size" {
  description = "Azure Kubernetes Node OS Disk Size"
  type = number
}

variable "aks_min_node_count" {
  description = "Azure Kubernetes Minimum Node Count"
  type = number
}

variable "aks_max_node_count" {
  description = "Azure Kubernetes Maximum Node Count"
  type = number
}

variable "aks_desired_node_count" {
  description = "Azure Kubernetes Desired Node Count"
  type = number
}

variable "aks_agents_max_pods" {
  description = "Azure Kubernetes max pod count"
  type = number
}

variable "aks_enable_auto_scaling" {
  description = "Azure Kubernetes auto scaling enable"
  type = bool
}

variable "aks_SLA_sku_tier" {
  description = "Azure Kubernetes SLA Sku Tier (Free/Paid)"
  type = string
}

variable "aks_node_pool_name" {
  description = "Azure Kubernetes node pool name"
  type = string
}

variable "aks_agents_type" {
  description = "Azure Kubernetes agent type"
  type = string
}

variable "aks_agents_size" {
  description = "Azure Kubernetes agent size"
  type = string
}

# Admin Service Principal
variable "aks_admin_spn" {
  description = "Azure Kubernetes Admin SPN"
  type = string
}
