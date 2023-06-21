variable "resource_group_name" {
    description = "VM Resource Group"
}

variable "location" {
    description = "VM Resource Group Location"
}

variable "virtual_network_name" {
    description = "The name of the vnet"
}

variable "vm_subnet_id" {
    description = "The id of the subnet to attach to the nic"
}

variable "vm_name" {
    description = "vm_name"
}

variable "vm_sku" {
    default     = "Standard_B2ms"
    description = "vm_name"
}

variable "admin_password" {
  
}
