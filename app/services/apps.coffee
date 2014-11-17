angular.module("services").service "AppsService",
  ($http, CONSTS) ->
    @all = () ->
      $http.get(CONSTS.appUrl + '/api/apps')
    @
