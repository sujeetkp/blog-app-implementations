output "db_fqdn" {
  value = azurerm_postgresql_server.postgresql.fqdn
}

output "db_private_link_ip" {
  value = azurerm_private_endpoint.azure_sql_private_endpoint.private_service_connection.0.private_ip_address
}

output "db_private_link_fqdn" {
  value = azurerm_private_dns_a_record.db_endpoint_dns_a_record.fqdn
}