variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy the Application Gateway."
}

variable "location" {
  type        = string
  description = "Specifies the Azure location where to deploy the Application Gateway."
}

variable "size" {
  type        = string
  description = "The size of this machine. Allowed values are like `Standard_D2s_v3`, `Standard_D4s_v3`, `Standard_D8s_v3` etc. Find out more on the valid VM sizes in each region at https://aka.ms/azure-regionservices."
  default     = "Standard_D2s_v3"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where the VM will be deployed."
}

variable "credentials" {
  type = object({
    user_name = string
    password  = string
  })
  description = "The user credential for Windows VM. This block requires the following inputs: \n  - `user_name`: The user name secret. \n  - `password`: The password secret."
}