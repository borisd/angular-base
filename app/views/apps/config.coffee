angular.module('app')
  .config ($stateProvider) ->
    $stateProvider.state("apps.index",
      url: ""
      controller: "AppsIndexController"
      templateUrl: "views/apps/index.html"
    )
