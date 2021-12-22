resource "azurerm_virtual_machine_scale_set_extension" "banm_vmssex" {
    name = "star-vmex-web"
    virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.banm_vmss.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${filebase64("install2.sh")}"
    }
    SETTINGS
}