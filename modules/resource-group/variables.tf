variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}

variable "resource_group_location" {
    description = "The location of the resource group"
    type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
    
  }
}