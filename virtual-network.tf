resource "azurerm_virtual_network" "this" {
    name                    = "grupo1-vnet"
    address_space           = ["12.0.0.0/16"]
    location                = azurerm_resource_group.this.location
    resource_group_name     = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["12.0.0.0/20"]
}