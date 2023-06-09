variable "db_server_name_prefix" {
  type = string
  description = "Postgre SQL DB Server Name Prefix"
}
variable "postgre_sku_name" {
  type = string
  description = "DB sku Name in Azure"
  default = "B_Gen5_1"
}
variable "db_size" {
  type = number
  description = "DB Size in MB"
}
variable "postgres_version" {
  type = string
  description = "Postgres Version"
}
variable "administrator_login" {
  type = string
  sensitive = true
  description = "Postgres Admin Username"
}
variable "administrator_login_password" {
  type = string
  sensitive = true
  description = "Postgres Admin Password"
}
variable "database_name" {
  type = string
  description = "Database name"
}