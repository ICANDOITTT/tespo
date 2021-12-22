resource "azurerm_virtual_machine_extension" "banm_vmex_web" {
    name = "banm-vmex-web"
    virtual_machine_id = azurerm_linux_virtual_machine.banm_vm_web.id
    publisher = "Microsoft.Azure.Extensions"
    type = "CustomScript"
    type_handler_version = "2.0"

    settings = <<SETTINGS
    {
        "script": "${filebase64("install1.sh")}"
    }
    SETTINGS

    depends_on = [ azurerm_linux_virtual_machine.banm_vm_web ]
}