angular.module("services").service "AppsService",
  ($timeout, $q) ->
    @all = (id, version) ->
      deferred = $q.defer()

      $timeout(
        ->
          deferred.resolve([ 'a', 'b'])
        , 1000
      )

      deferred.promise

    @
