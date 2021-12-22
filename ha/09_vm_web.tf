resource "azurerm_linux_virtual_machine" "banm_vm_web" {    #web부분 작업 시작!
    name = "banm-vm-web"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    network_interface_ids = [azurerm_network_interface.banm_web_nwif.id]
    size = "Standard_DS1_v2"
    admin_username = "web"
    admin_password = "gkwltnsmscjswo1!"
    disable_password_authentication = false

    /*admin_ssh_key {
      username = "web"
      public_key = azurerm_ssh_public_key.banm_ssh.public_key
    }*/

    source_image_reference {
      publisher = "OpenLogic"
      offer = "CentOS"
      sku   = "7.5"
      version = "latest"
    }

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }

    depends_on = [ azurerm_network_interface.banm_web_nwif ]
}