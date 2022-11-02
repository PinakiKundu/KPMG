resource "azurerm_network_interface" "nic" {
  name                = "${module.naming.network_interface.name}-vm"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  name                = module.naming.windows_virtual_machine.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size

  admin_username = var.credentials.user_name
  admin_password = var.credentials.password


  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}