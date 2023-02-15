module "module_azurerm_public_ip" {
  for_each = local.public_ips

  source = "../azure/rm/azurerm_public_ip"

  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  name              = each.value.name
  allocation_method = each.value.allocation_method
  sku               = each.value.sku
}

output "public_ips" {
  value = var.enable_module_output ? module.module_azurerm_public_ip[*] : null
}
