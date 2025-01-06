resource azurerm_app_service_plan "example" {
  name                = "terragoat-app-service-plan-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Dynamic"
    size = "S1"
  }
}

resource azurerm_app_service "app-service1" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name
  https_only          = false
  site_config {
    min_tls_version = "1.1"
  }
}

resource azurerm_app_service "app-service2" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name
  https_only          = true

  auth_settings {
    enabled = false
  }
}

resource "azurerm_app_service" "app-service3" {
  app_service_plan_id   = azurerm_app_service_plan.example.id
  location              = var.location
  name                  = "terragoat-app-service-${var.environment}-deployment"
  resource_group_name   = azurerm_resource_group.example.name
  https_only            = true

  site_config {
    min_tls_version = "1.2"
  }

  auth_settings {
    enabled = true
  }

  connection_string {
    name  = "MyConnectionString"
    type  = "SQLAzure"
    value = "Server=tcp:myserver.database.windows.net,1433;Database=mydatabase;User ID=myuser;Password=mypassword;Encrypt=true;Connection Timeout=30;"
  }
}
