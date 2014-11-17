angular.module("filters.uppercase", []).filter "uppercase",
  ->
    (text) ->
      (if text then text.toUpperCase() else text)
