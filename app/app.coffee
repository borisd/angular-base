angular.element(document).ready ->
  angular.bootstrap(document, ["app"])

angular.module "app", [
  "ui.router"
  "xeditable"
  "angularSpinner"
]
