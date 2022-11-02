module "win_vm" {
  source = "../modules/vm"

  location            = local.location
  resource_group_name = azurerm_resource_group.resource.name
  subnet_id           = azurerm_subnet.resource_subnet.id

  credentials = {
    user_name = "adminuser" #Ideally we should fetch from Key Vault.
    password  = "P@$$w0rd1234!" #Its just for illustration
  }
}

# Enabling IIS Server on VM using custom script extension
resource "azurerm_virtual_machine_extension" "vm_extension_install_iis" {
  name                       = "vm_extension_install_iis"
  virtual_machine_id         = module.win_vm.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}