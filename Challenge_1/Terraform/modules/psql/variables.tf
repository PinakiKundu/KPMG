variable "resource_group_name" {
  type        = string
  description = "The resource group name to deploy the Application Gateway."
}

variable "location" {
  type        = string
  description = "Specifies the Azure location where to deploy the Application Gateway."
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID to use for the Private endpoint of the postgreSQL server."
}

variable "sku_name" {
  type        = string
  description = "Specifies the SKU Name for this Postgres Server."
  default     = "GP_Gen5_2"
}

variable "credentials" {
  type = object({
    user_name = string
    password  = string
  })
  description = "The user credential for PostgreSQL. This block requires the following inputs: \n  - `user_name`: The user name secret. \n  - `password`: The password secret."
}

variable "backup_retention_days" {
  type        = number
  description = "Specifies the backup retention days (fixed to 35 days for Production environment)."
  default     = 7
  validation {
    condition = (
      var.backup_retention_days >= 7
      && var.backup_retention_days <= 35
    )
    error_message = "Invalid backup retention days. Interval must be an integer between 1 and 35."
  }
}