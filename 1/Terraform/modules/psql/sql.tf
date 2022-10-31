resource "azurerm_postgresql_server" "psql" {
  name                = module.naming.postgresql_server
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.credentials.user_name
  administrator_login_password = var.credentials.password

  sku_name   = var.sku_name
  version    = "11"
  storage_mb = 51200

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  identity {
    type = "SystemAssigned"
  }
}