locals {
  location = "northeurope"
  stage    = "dev"
}

module "database" {
  source = "./module/cosmos_database"

  stage          = local.stage
  name           = "skillup-database"
  location       = local.location
  resource_group = "cosmosdb"
}

module "rsg_api" {
  source = "./module/resource_group"

  stage    = local.stage
  name     = "skillup-api"
  location = local.location
  service  = "functionsBackend"
}

module "function_app" {
  source = "./module/function_app"

  stage            = local.stage
  name             = "skillup"
  location         = local.location
  resource_group   = module.rsg_api.name
  account_endpoint = module.database.account_endpoint
  account_key      = module.database.account_key
}

module "function_get" {
  source = "./module/function_app_function"

  stage           = local.stage
  name            = "get"
  function_app_id = module.function_app.function_app_id
  script          = "get.js"
  config = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "req",
        "methods" : [
          "get"
        ]
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "res"
      },
      {
        "name" : "data",
        "databaseName" : module.database.database_name,
        "collectionName" : module.database.collection,
        "connectionStringSetting" : "COSMOS_DATABASE_CONNECTION",
        "direction" : "in",
        "type" : "cosmosDB",
        "sqlQuery" : "select * from c"
      }
    ]
  })
}

module "function_insert" {
  source = "./module/function_app_function"

  stage           = local.stage
  name            = "insert"
  function_app_id = module.function_app.function_app_id
  script          = "insert.js"
  config = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "req",
        "methods" : [
          "post"
        ]
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "res"
      },
      {
        "name" : "data",
        "databaseName" : module.database.database_name,
        "collectionName" : module.database.collection,
        "connectionStringSetting" : "COSMOS_DATABASE_CONNECTION",
        "direction" : "out",
        "type" : "cosmosDB",
      }
    ]
  })
}

module "function_get_collection_by_id" {
  source = "./module/function_app_function"

  stage           = local.stage
  name            = "get-collection-by-id"
  function_app_id = module.function_app.function_app_id
  script          = "get_collection_by_id.js"
  config = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "req",
        "methods" : [
          "get"
        ],
        "route" : "cards/{collection_id}"
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "res"
      },
      {
        "name" : "data",
        "databaseName" : module.database.database_name,
        "collectionName" : module.database.collection,
        "connectionStringSetting" : "COSMOS_DATABASE_CONNECTION",
        "direction" : "in",
        "type" : "cosmosDB",
        "sqlQuery" : "select * from c where c.collection_id = {collection_id}"
      }
    ]
  })
}

module "function_delete_card_by_id" {
  source = "./module/function_app_function"

  stage           = local.stage
  name            = "delete-card-by-id"
  function_app_id = module.function_app.function_app_id
  script          = "delete_card_by_id.js"
  config = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "req",
        "methods" : [
          "get"
        ],
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "res"
      },
      {
        "name" : "data",
        "databaseName" : module.database.database_name,
        "collectionName" : module.database.collection,
        "connectionStringSetting" : "COSMOS_DATABASE_CONNECTION",
        "direction" : "out",
        "type" : "cosmosDB",
      }
    ]
  })
}

module "rsg_web_app" {
  source = "./module/resource_group"

  stage    = local.stage
  name     = "skillup-app"
  location = local.location
  service  = "Web Service"
}

module "app_service_plan" {
  source = "./module/app_service_plan"

  stage          = local.stage
  name           = "skillup"
  resource_group = module.rsg_web_app.name
  location       = local.location
  os_type        = "Linux"
  sku_name       = "B1"
}

module "web_app" {
  source = "./module/web_app"

  stage               = local.stage
  name                = "skillup"
  resource_group      = module.rsg_web_app.name
  location            = local.location
  app_service_plan_id = module.app_service_plan.app_service_plan_id
}
