/*
locals {
  nodes = {
    for i in range(3) : "worker${i}" => {
      name           = substr("worker${i}${random_id.prefix.hex}", 0, 8)
      vm_size        = "Standard_D2s_v3"
      vnet_subnet_id = azurerm_subnet.test.id
      min_count      = 2
      max_count      = 2
      max_pods       = 100
      mode           = "User"
      os_disk_size_gb = 30
      os_disk_type    = "Managed"
      os_type         = "Linux"
      # enable_node_public_ip = false
      # enable_host_encryption = true
      # enable_auto_scaling = false
      # node_count     = 1     
    }
  }
}
*/

module "aks" {

    depends_on = [
    azurerm_virtual_network.vnet
  ]

  # Update Source and Version when there is a new release of this module.
  # source = "github.com/Azure/terraform-azurerm-aks"
  source  = "Azure/aks/azurerm"
  version = "7.1.0"

  prefix                           = local.resource_name_prefix
  cluster_name                     = var.aks_cluster_name

  resource_group_name              = azurerm_resource_group.rg.name

  kubernetes_version               = var.aks_cluster_version
  orchestrator_version             = var.aks_cluster_version

  vnet_subnet_id                   = azurerm_subnet.aks_subnet.id
  enable_host_encryption           = false

  workload_identity_enabled        = true
  oidc_issuer_enabled              = true

  sku_tier                         = var.aks_SLA_sku_tier 

  rbac_aad                         = true  # Integration with Azure AD
  role_based_access_control_enabled = true # k8s RBAC enabled
  rbac_aad_managed                 = true  # This must be true for providing admin AD groups
  rbac_aad_admin_group_object_ids  = [azuread_group.aks_cluster_admins.id]
  # rbac_aad_azure_rbac_enabled    = false # THis enabled Azure AD RBAC, instead of k8s RBAC
  local_account_disabled           = true

  private_cluster_enabled          = false
  public_network_access_enabled    = true
  api_server_authorized_ip_ranges  = ["0.0.0.0/0"]
  http_application_routing_enabled = false
  ingress_application_gateway_enabled = false
  # ingress_application_gateway_name = "aks-agw"
  # ingress_application_gateway_subnet_cidr = "10.52.1.0/24"

  network_plugin                   = var.aks_network_plugin
  # network_policy                   = var.aks_network_policy
  azure_policy_enabled             = var.aks_enable_azure_policy  # "True" only for AzureCNI
  # net_profile_dns_service_ip     = "10.0.0.10"       # Required for AzureCNI
  # net_profile_docker_bridge_cidr = "170.10.0.1/16"   # Required for AzureCNI
  # net_profile_service_cidr       = "10.0.0.0/16"     # Required for AzureCNI

  # Primary Node Pool Configuration
  enable_auto_scaling              = var.aks_enable_auto_scaling
  agents_pool_name                 = var.aks_node_pool_name
  agents_min_count                 = var.aks_min_node_count
  agents_max_count                 = var.aks_max_node_count
  # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_count                     = var.aks_enable_auto_scaling == true ? null : var.aks_desired_node_count 
  agents_max_pods                  = var.aks_agents_max_pods
  # agents_availability_zones        = ["1", "2"]
  agents_type                      = var.aks_agents_type
  agents_size                      = var.aks_agents_size
  os_disk_size_gb                  = var.aks_node_os_disk_size
  
  public_ssh_key                   = file("${path.module}/ssh-keys/terraform-azure.pub")
  admin_username                   = "azureuser"

  
  # Additional Node Pools
  # node_pools                    = local.nodes


  agents_tags = local.common_tags

}