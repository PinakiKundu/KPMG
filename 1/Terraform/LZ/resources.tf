module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["pk-assemnt"]
}

locals {
  location = "West Europe"
}
