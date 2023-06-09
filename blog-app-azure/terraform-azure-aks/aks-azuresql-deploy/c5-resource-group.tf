# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags = local.common_tags
}

output "aks_resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "aks_resource_group_name" {
  value = azurerm_resource_group.rg.name
}
