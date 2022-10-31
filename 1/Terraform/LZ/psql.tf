module "psql" {
  source = "../modules/psql"

  credentials = {
    user_name = "username" #Ideally we should fetch from Key Vault.
    password  = "passw0rd" #Its just for illustration
  }
  location            = local.location
  resource_group_name = azurerm_resource_group.resource.name
  subnet_id           = azurerm_subnet.resource_subnet.id
}