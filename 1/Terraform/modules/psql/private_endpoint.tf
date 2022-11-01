resource "azurerm_private_endpoint" "private_endpoint" {
  name                = module.naming.private_endpoint.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    private_connection_resource_id = azurerm_postgresql_server.psql.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }
}
