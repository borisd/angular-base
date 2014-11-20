angular.module('app').factory "httpInterceptor",
  ($q, $log) ->
    request: (config) ->
      config

    requestError: (rejection) ->
      $log.debug rejection
      $q.reject rejection

    response: (response) ->
      $log.debug "response: ", response
      response

    responseError: (rejection) ->
      $log.debug rejection
      $q.reject rejection
