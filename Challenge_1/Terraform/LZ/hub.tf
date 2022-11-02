resource "azurerm_resource_group" "hub" {
  name     = "${module.naming.resource_group.name}-hub"
  location = local.location
}

# Network configuration ##
#------------------------#
resource "azurerm_virtual_network" "hub" {
  name                = "${module.naming.virtual_network.name}-hub"
  location            = local.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.10.0.0/16"]
}

# Subnet for AGW deployment #
resource "azurerm_subnet" "gateway_subnet" {
  name                 = module.naming.subnet.name
  resource_group_name  = azurerm_virtual_network.hub.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.10.1.0/24"]
  service_endpoints    = ["Microsoft.KeyVault"]
}

# You must allow incoming Internet traffic on TCP ports 65200-65535 for the v2 SKU with the destination subnet as Any and source as GatewayManager service tag.
# This port range is required for Azure infrastructure communication. These ports are protected (locked down) by Azure certificates.
# External entities, including the customers of those gateways, can't communicate on these endpoints.
resource "azurerm_network_security_group" "gateway_subnet_nsg" {
  name                = module.naming.network_security_group.name
  location            = local.location
  resource_group_name = azurerm_resource_group.hub.name

  security_rule {
    name                       = "agw-network-security-rule-healthcheck"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "gateway_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.gateway_subnet.id
  network_security_group_id = azurerm_network_security_group.gateway_subnet_nsg.id

  depends_on = [azurerm_subnet.gateway_subnet]
}
#----------------------#
# End of network block #