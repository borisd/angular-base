MainCtrl = ($log) ->
  return

run = ($log) ->
  $log.debug "App is running!"

angular.element(document).ready ->
  angular.bootstrap(document, ["app"])

angular.module "vendor", [
  "ui.router"
  "xeditable"
  "angularSpinner"
]

angular.module "controllers", []

angular.module "services", []

angular.module "models", []

angular.module "filters", [
  "filters.uppercase"
]

angular.module "interceptors", [
  "interceptors.http"
]

angular.module "directives", [
  "directives.custom_page"
  "directives.theme"
]
angular.module "views", [
  "views.auth"
  "views.apps"
]

angular.module("app", [
  "consts"
  "vendor"
  "routes"
  "filters"
  "interceptors"
  "directives"
  "controllers"
  "templates"
  "services"
  "views"
])
  .run(run)
  .controller("MainCtrl", MainCtrl)
  .value "version", "0.0.1"
