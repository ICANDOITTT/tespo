resource "azurerm_virtual_network" "banm_vpc" {
  name  =   "banm-vpc"
  location = azurerm_resource_group.banm_rg.location
  resource_group_name = azurerm_resource_group.banm_rg.name
  address_space = ["10.0.0.0/16"]

  depends_on = [ azurerm_resource_group.banm_rg ]
}