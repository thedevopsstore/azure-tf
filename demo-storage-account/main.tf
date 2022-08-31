# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create resource group

resource "azurerm_resource_group" "rg" {
  name     = "lwplabsrg"
  location = "East US 2"

  tags = {
    environment = "Terraform Storage"
    CreatedBy   = "TF Admin"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "lwplabsstoragebatman"
  resource_group_name      = resource.azurerm_resource_group.rg.name
  location                 = resource.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

## secondary storage account with variables
variable "sa-name" {}

variable "location" {}

variable "rg-name" {}

resource "azurerm_storage_account" "savar" {
  name                     = var.sa-name
  resource_group_name      = var.rg-name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}


