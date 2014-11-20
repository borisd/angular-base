angular.module('app').directive "customPage", ->
  restrict: "A"
  controller: [
    "$scope", "$element", "$location", ($scope, $element, $location) ->

      path = ->
        $location.path()

      addBg = (path) ->

        # remove all the classes
        $element.removeClass "body-wide body-err body-lock body-auth"

        # add certain class based on path
        switch path
          when "/404", "/pages/404", "/pages/500"
            $element.addClass "body-wide body-err"
          when "/sign_in", "/sign_up", "/forgot-password"
            $element.addClass "body-wide body-auth"
          when "/pages/lock-screen"
            $element.addClass "body-wide body-lock"

      addBg($location.path())

      $scope.$watch path, (newVal, oldVal) ->
        addBg($location.path()) unless newVal is oldVal
  ]
