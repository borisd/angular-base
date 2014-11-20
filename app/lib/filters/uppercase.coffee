angular.module('app').filter "uppercase",
  ->
    (text) ->
      (if text then text.toUpperCase() else text)
