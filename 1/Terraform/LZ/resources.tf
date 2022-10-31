module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["pk-assemnt"]
}

locals {
  location = "West Europe"
}

resource "azurerm_resource_group" "group" {
  name     = module.naming.resource_group
  location = local.location
}
