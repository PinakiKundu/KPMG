resource "azurerm_resource_group" "resource" {
  name     = module.naming.resource_group
  location = local.location
}

# Network configuration ##
#------------------------#
resource "azurerm_virtual_network" "spoke" {
  name                = "${module.naming.virtual_network}-spoke"
  location            = local.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.10.0.0/16"]
}

# Subnet for AGW deployment #
resource "azurerm_subnet" "resource_subnet" {
  name                 = module.naming.subnet
  resource_group_name  = azurerm_virtual_network.spoke.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.10.1.0/24"]
  service_endpoints    = ["Microsoft.KeyVault"]
}