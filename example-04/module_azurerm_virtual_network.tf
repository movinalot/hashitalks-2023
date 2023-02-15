module "module_azurerm_virtual_network" {
  for_each = local.virtual_networks

  source = "../azure/rm/azurerm_virtual_network"

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name          = each.value.name
  address_space = each.value.address_space
}

output "virtual_networks" {
  value = var.enable_module_output ? module.module_azurerm_virtual_network[*] : null
}
