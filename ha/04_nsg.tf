resource "azurerm_network_security_group" "banm_nsg1" {     #elb는 80번 포트
    name = "banm-nsg1"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    security_rule {
        name = "http-rule"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    depends_on = [azurerm_subnet.banm_sub1]

}

resource "azurerm_network_security_group" "banm_nsg2" {     #web은 80번 포트
    name = "banm-nsg2"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    security_rule {
        name = "http-rule"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    depends_on = [azurerm_subnet.banm_sub2]

}

resource "azurerm_network_security_group" "banm_nsg3" {     #ilb, was는 8080포트
    name = "banm-nsg3"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    security_rule {
        name = "tomcat-rule"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "8080"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    depends_on = [azurerm_subnet.banm_sub3]

}

resource "azurerm_network_security_group" "banm_nsg4" {     #db는 아무포트 읍다~
    name = "banm-nsg4"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    depends_on = [azurerm_subnet.banm_sub4]
}

/*resource "azurerm_network_security_group" "banm_nsg6" {     #image를 딸때 재배포 git 사용을 위해 80, tomcat을 위한 8080 이다~ 
    name = "banm-nsg6"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    security_rule {
        name = "http-rule"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "tomcat-rule"
        priority = 110
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "8080"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }

    depends_on = [azurerm_subnet.banm_sub6]
} */