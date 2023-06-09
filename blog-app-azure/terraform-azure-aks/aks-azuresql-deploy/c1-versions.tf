# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.59.0" 
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
    time = {
      source = "hashicorp/time"
      version = "0.9.1"
    }     
  }

  backend "azurerm" {}

}

# Provider Block
provider "azurerm" {
 features {}          
}

provider "time" {
  # Configuration options
}
