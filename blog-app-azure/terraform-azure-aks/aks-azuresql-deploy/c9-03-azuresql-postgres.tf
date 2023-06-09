resource "azurerm_postgresql_server" "postgresql" {
  name                = lower(local.db_server_name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name                     = var.postgre_sku_name
  version                      = var.postgres_version
  storage_mb                   = var.db_size
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  tags = local.tags
}

resource "azurerm_postgresql_database" "pgdatabase" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}