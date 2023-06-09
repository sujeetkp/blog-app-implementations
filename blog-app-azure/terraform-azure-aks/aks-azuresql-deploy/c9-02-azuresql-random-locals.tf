locals {
  prefix = var.db_server_name_prefix
  db_server_name = "${local.prefix}-${var.environment}-${var.business_divsion}-${random_string.random.id}"
  tags = {
    department = var.business_divsion
    environment = var.environment
  }
}

# Random String - For AzureSQL
resource "random_string" "random" {
  length           = 7
  special          = false
}