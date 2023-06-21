variable "storage_account_name" {
    description = "The account name"
}

variable "resource_group_name" {
    description = "The name of the resource group"
}

variable "location" {
    description = "Location"
}

variable "subnet_id" {
    description = "subnet Id"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}



