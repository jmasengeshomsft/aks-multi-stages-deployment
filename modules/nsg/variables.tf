variable "resource_group_name" {
    description = "NSG Resource Group"
}

variable "location" {
    description = "Location"
}

variable "nsg_name" {
    description = "NSG Name"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}

variable "nsg_rules" {
  type = list(object({
    name                                        = string
    priority                                    = number
    direction                                   = string
    access                                      = string
    protocol                                    = string
    source_port_range                           = string
    destination_port_range                      = string
    source_address_prefix                       = string
    destination_address_prefix                  = string
    description                                 = string
    destination_address_prefixes                = list(string)
    destination_application_security_group_ids  = list(string)
    destination_port_ranges                     = list(string)
    source_address_prefixes                     = list(string)
    source_application_security_group_ids       = list(string)
    source_port_ranges                          = list(string)
  }))
  default = [
  ]
}