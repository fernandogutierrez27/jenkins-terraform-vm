# resource "azurerm_virtual_network" "this" {
#     name                    = var.vm_vnet.name
#     address_space           = var.vm_vnet.address_space
#     location                = azurerm_resource_group.this.location
#     resource_group_name     = azurerm_resource_group.this.name
# }

resource "azurerm_subnet" "this" {
  name                 = var.vm_subnet.name
  resource_group_name  = var.vm_subnet.resource_group
  virtual_network_name = var.vm_subnet.vnet_name
  address_prefixes     = var.vm_subnet.address_prefixes
}