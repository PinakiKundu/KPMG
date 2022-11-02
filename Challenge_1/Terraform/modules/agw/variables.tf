variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy the Application Gateway."
}

variable "location" {
  type        = string
  description = "Specifies the Azure location where to deploy the Application Gateway."
}

variable "agw_subnet_id" {
  type        = string
  description = "Application Gateway frontend subnet for gateway IP configuration."
}


variable "backend_address_pools" {
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  description = "Backend pools that you'd like to have on the mule Application Gateway. This block requires the following inputs: \n  - `name` (Required) = The name of the Backend Address Pool. \n  - `fqdns` (Optional) = A list of FQDN's which should be part of the Backend Address Pool. \n  - `ip_addresses` (Optional) = A list of IP Addresses that should be part of the Backend Address Pool."
}

variable "backend_http_settings" {
  type = list(object({
    name            = string
    port            = number
    protocol        = string
    path            = optional(string)
    request_timeout = number
  }))
  description = "Nested map with backend settings. This block requires the following inputs:  \n  - `name` (Required) = The name of the Backend HTTP Settings Collection.    \n  - `path` (Optional) = The Path which should be used as a prefix for all HTTP requests.  \n  - `port` (Required) The port which should be used for this Backend HTTP Settings Collection.    \n  - `protocol` (Required) The Protocol which should be used. Possible values are Http and Https."
}

variable "request_routing_rules" {
  type = list(object({
    name                       = string
    rule_type                  = optional(string)
    backend_address_pool_name  = optional(string)
    backend_http_settings_name = optional(string)
  }))
  default     = []
  description = "List of Request routing rules to be used for listeners.  This block requires the following inputs:  \n  - `name` (Required) = The Name of this Request Routing Rule.    \n  - `rule_type` (Optional) = The Type of Routing that should be used for this Rule. Possible values are Basic and PathBasedRouting.  \n  - `backend_address_pool_name` (Optional) = The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set.    \n  - `backend_http_settings_name` (Optional) = The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if redirect_configuration_name is set."
}