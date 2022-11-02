module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["pk-assemnt"]
}

resource "azurerm_public_ip" "ip" {
  name                = module.naming.public_ip.name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  resource_group_name = var.resource_group_name
}