resource "azurerm_subnet_network_security_group_association" "banm_nsgass1" {
    subnet_id = azurerm_subnet.banm_sub1.id
    network_security_group_id = azurerm_network_security_group.banm_nsg1.id
    depends_on = [azurerm_network_security_group.banm_nsg1]
}

resource "azurerm_subnet_network_security_group_association" "banm_nsgass2" {
    subnet_id = azurerm_subnet.banm_sub2.id
    network_security_group_id = azurerm_network_security_group.banm_nsg2.id

    depends_on = [azurerm_network_security_group.banm_nsg2]
}

resource "azurerm_subnet_network_security_group_association" "banm_nsgass3" {
    subnet_id = azurerm_subnet.banm_sub3.id
    network_security_group_id = azurerm_network_security_group.banm_nsg3.id

    depends_on = [azurerm_network_security_group.banm_nsg3]
}

resource "azurerm_subnet_network_security_group_association" "banm_nsgass4" {
    subnet_id = azurerm_subnet.banm_sub4.id
    network_security_group_id = azurerm_network_security_group.banm_nsg4.id

    depends_on = [azurerm_network_security_group.banm_nsg4]
}

/*resource "azurerm_subnet_network_security_group_association" "banm_nsgass6" {
    subnet_id = azurerm_subnet.banm_sub6.id
    network_security_group_id = azurerm_network_security_group.banm_nsg6.id

    depends_on = [azurerm_network_security_group.banm_nsg6]
}*/
