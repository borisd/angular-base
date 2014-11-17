angular.module("views.apps").controller("AppsIndexController", [
  "$scope", "AppsService", ($scope, AppsService) ->

    AppsService.all().then (apps) ->
      $scope.apps = apps.data
])
