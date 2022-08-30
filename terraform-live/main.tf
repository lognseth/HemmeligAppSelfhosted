resource "azurerm_resource_group" "rg" {
  name     = "hemmelig-rg"
  location = "West Europe"
}

resource "azurerm_container_group" "example" {
  name                = "hemmelig-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "hemmeligapp"
  os_type             = "Linux"

  container {
    name   = "hemmelig"
    image  = "hemmeligapp/hemmelig:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  container {
    name   = "redis"
    image  = "redis:latest"
    cpu    = "0.5"
    memory = "1.5"
  }

  ports {
    port     = 6379
    protocol = "TCP"
  }

  tags = {
    environment = "testing"
  }
}
