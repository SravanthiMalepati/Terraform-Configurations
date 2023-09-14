resource "azurerm_mysql_flexible_server" "mysql-server" {
  name = "${var.prefix}-mysql-server"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
 
  administrator_login = var.admin_login
  administrator_password = var.admin_password
 
  sku_name = "GP_Standard_D2ds_v4"
  version = "5.7"
}

resource "azurerm_mysql_flexible_database" "mysql-db" {
  name                = "${var.prefix}_mysql"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "mysql-fw-rule" {
  name                = "${var.prefix}-mysql-fw-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

output "mysql_server" {
  value = azurerm_mysql_flexible_server.mysql-server
  sensitive = true
}

output mysql_db {
  value = azurerm_mysql_flexible_database.mysql-db.name
}