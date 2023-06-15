resource "azurerm_function_app_function" "function" {
  name            = "${var.stage}-fn-${var.name}"
  function_app_id = var.function_app_id
  language        = "Javascript"

  file {
    name    = "index.js"
    content = file("function_scripts/${var.script}")
  }

  test_data = jsonencode({
    "body" : null
  })

  config_json = var.config
}
