variable "resource_group_name" {
  description = "resource_group_name"
  type        = string
  default     = "hashitalks-example-01"
}

variable "resource_group_location" {
  description = "resource_group_location"
  type        = string
  default     = "eastus"
}

variable "enable_module_output" {
  description = "Enable/Disable module output"
  default     = true
}