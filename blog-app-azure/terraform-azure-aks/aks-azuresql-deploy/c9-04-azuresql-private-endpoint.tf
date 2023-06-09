# Create Private DNS Zone
resource "azurerm_private_dns_zone" "db_zone" {
  name                = "postgres.database.internal.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Link Private Zone with VNET
resource "azurerm_private_dns_zone_virtual_network_link" "db_private_dns_link" {
  name = "db-private-dns-link"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.db_zone.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

# Create a Private Link for the Azure SQL Resource
resource "azurerm_private_endpoint" "azure_sql_private_endpoint" {
  depends_on = [ 
    azurerm_postgresql_server.postgresql,
    azurerm_private_dns_zone.db_zone
  ]
  name                = "blog-azure-sql-endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.dbsubnet.id

  private_service_connection {
    name                           = "blog-azure-sql-endpoint-privateserviceconnection"
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id
    subresource_names              = [ "postgresqlServer" ]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "db-private-dns-link"
    private_dns_zone_ids = [azurerm_private_dns_zone.db_zone.id]
  }
}

# Create a "A" record in Private DNS Zone for Azure SQL Private Link IP
resource "azurerm_private_dns_a_record" "db_endpoint_dns_a_record" {
  depends_on = [
    azurerm_private_endpoint.azure_sql_private_endpoint
  ]
  name = lower(local.db_server_name)
  zone_name = azurerm_private_dns_zone.db_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl = 300
  records = [azurerm_private_endpoint.azure_sql_private_endpoint.private_service_connection.0.private_ip_address]
}