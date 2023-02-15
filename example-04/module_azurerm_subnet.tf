module "module_azurerm_subnet" {
  for_each = local.subnets

  source = "../azure/rm/azurerm_subnet"

  resource_group_name = each.value.resource_group_name

  name             = each.value.name
  vnet_name        = each.value.vnet_name
  address_prefixes = each.value.address_prefixes
}

output "subnets" {
  value = var.enable_module_output ? module.module_azurerm_subnet[*] : null
}
