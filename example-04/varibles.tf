variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
  default     = "hashitalks_dynamic_lb_fe_ip"
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
  default     = "eastus2"
}

variable "virtual_network_name" {
  description = "virtual_network_name"
  type        = string
  default     = "vnet_1"
}

variable "virtual_network_address_space" {
  description = "virtual_network_address_space"
  type        = list(string)
  default     = ["10.125.0.0/16"]
}

variable "enable_module_output" {
  description = "Enable/Disable module output"
  default     = true
}