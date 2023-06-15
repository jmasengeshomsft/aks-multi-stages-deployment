variable "resource_group_name" {
    description = "Route table Resource Group"
}

variable "location" {
    description = "Route table location"
}


variable "route_table_name" {
    description = "Route table name"
}

variable "virtual_appliance_ip" {
    description = "The ip address of the virtual appliance where to send the traffic"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}
