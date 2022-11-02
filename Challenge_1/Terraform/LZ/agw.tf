## Main Application Gateway module ##
#-----------------------------------#
module "appgateway" {
  source = "../modules/agw"

  resource_group_name = azurerm_resource_group.hub.name
  location            = local.location
  agw_subnet_id       = azurerm_subnet.gateway_subnet.id


  backend_address_pools = [
    {
      "name"         = "pool-dev"
      "ip_addresses" = [module.win_vm.private_ip]
    }
  ]

  request_routing_rules = [
    {
      "backend_address_pool_name"  = "pool-dev"
      "backend_http_settings_name" = "dev-http-settings"
      "name"                       = "dev-routing"
      "rule_type"                  = "Basic"
    }
  ]

  backend_http_settings = [
    {
      "name"            = "dev-http-settings"
      "port"            = "80"
      "protocol"        = "Http"
      "request_timeout" = 100
    }
  ]
}
#--------------------#
# End of AGW module #