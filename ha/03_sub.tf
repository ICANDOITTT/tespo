resource "azurerm_subnet" "banm_sub1" { #elb subnet
    name = "subnet01-elb"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "banm_sub2" {     #web subnet
    name = "subnet02-web"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "banm_sub3" {     #was subnet
    name = "subnet03-was"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "banm_sub4" {     #endpoint subnet
    name = "subnet04-db"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.4.0/24"]

    #subnet4에서 private endpoint를 쓸수있도록 허락해주는 것
    enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "banm_sub5" {  #bastion을 사용하기 위한 subnet
    name = "AzureBastionSubnet"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.5.0/24"]
}

/*resource "azurerm_subnet" "banm_sub6" {     #image를 따기위한 was subnet
    name = "subnet06-image"
    resource_group_name = azurerm_resource_group.banm_rg.name
    virtual_network_name = azurerm_virtual_network.banm_vpc.name
    address_prefixes = ["10.0.6.0/24"]
}*/