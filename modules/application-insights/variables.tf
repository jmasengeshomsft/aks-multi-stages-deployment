variable "app_insights_name" {
    description = "The name of the application insights"
}

variable "location" {
    description = "The location of the application insights"
} 

variable "law_workspace_id" {
    description = "The workspace id of the application insights"
}

variable "resource_group_name" {
    description = "The name of registry"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}