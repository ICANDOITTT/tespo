resource "azurerm_public_ip" "banm_bastionip" {
    name = "banm-bastionip"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_bastion_host" "banm_bastion" {
    name = "banm-bastion"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    ip_configuration {
        name = "configuration"
        subnet_id = azurerm_subnet.banm_sub5.id
        public_ip_address_id = azurerm_public_ip.banm_bastionip.id
    }

    depends_on = [ azurerm_public_ip.banm_bastionip ]
}