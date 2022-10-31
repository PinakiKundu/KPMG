output "virtual_machine_id" {
  value = azurerm_windows_virtual_machine.this.id
}

output "private_ip" {
  value = azurerm_windows_virtual_machine.this.private_ip_address
}
