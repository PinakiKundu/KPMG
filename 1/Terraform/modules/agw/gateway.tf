resource "azurerm_application_gateway" "agw" {
  name                = module.naming.application_gateway.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  enable_http2 = true

  # The Subnet which the Application Gateway should be connected to.
  gateway_ip_configuration {
    name      = "agw-ip-config"
    subnet_id = var.agw_subnet_id
  }

  # The Name of the Frontend Port use for each HTTP Listener.
  frontend_port {
    name = "agw-fend-port"
    port = 80
  }

  # Public ip frontend configuration.
  frontend_ip_configuration {
    name                 = "agw-fend-ip-config"
    public_ip_address_id = azurerm_public_ip.ip.id
  }

  # A list of backend_address_pool, could be ip address or fqdns.
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    iterator = backend_pool
    content {
      name         = backend_pool.value["name"]
      fqdns        = lookup(backend_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_pool.value, "ip_addresses", null)
    }
  }

  #
  # Backend HTTP settings
  #
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    iterator = backend_settings
    content {
      name                  = backend_settings.value["name"]
      cookie_based_affinity = "Disabled"
      path                  = backend_settings.value["path"]
      port                  = backend_settings.value["port"]
      protocol              = backend_settings.value["protocol"]
      request_timeout       = backend_settings.value["request_timeout"]
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    iterator = rrt
    content {
      name                       = rrt.value["name"]
      rule_type                  = lookup(rrt.value, "rule_type", "Basic")
      http_listener_name         = "agw-http-listener"
      backend_address_pool_name  = lookup(rrt.value, "backend_address_pool_name", null)
      backend_http_settings_name = lookup(rrt.value, "backend_http_settings_name", null)
      priority                   = 1
    }
  }

  http_listener {
    name                           = "agw-http-listener"
    frontend_ip_configuration_name = "agw-fend-ip-config"
    frontend_port_name             = "agw-fend-port"
    protocol                       = "Http"
  }
}