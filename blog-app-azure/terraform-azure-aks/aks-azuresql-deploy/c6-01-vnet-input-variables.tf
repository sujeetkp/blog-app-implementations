# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}


# Private Subnet Name
variable "private_subnet_name" {
  description = "Virtual Network Private Subnet Name"
  type = string
  default = "private-subnet"
}
# Private Subnet Address Space
variable "private_subnet_address" {
  description = "Virtual Network Private Subnet Address Spaces"
  type = list(string)
  default = ["10.0.1.0/24"]
}


# AKS Subnet Name
variable "aks_subnet_name" {
  description = "Virtual Network AKS Subnet Name"
  type = string
  default = "aks-subnet"
}
# AKS Subnet Address Space
variable "aks_subnet_address" {
  description = "Virtual Network AKS Subnet Address Spaces"
  type = list(string)
  default = ["10.0.11.0/24"]
}


# Database Subnet Name
variable "db_subnet_name" {
  description = "Virtual Network Database Subnet Name"
  type = string
  default = "db-subnet"
}
# Database Subnet Address Space
variable "db_subnet_address" {
  description = "Virtual Network Database Subnet Address Spaces"
  type = list(string)
  default = ["10.0.21.0/24"]
}


# Bastion / Management Subnet Name / Public Subnet
variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type = string
  default = "bastion-subnet"
}
# Bastion / Management Subnet Address Spacev/ Public Subnet
variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type = list(string)
  default = ["10.0.100.0/24"]
}



