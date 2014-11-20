angular.module("app").directive 'noPropogate', () ->
  restrict: 'A'
  link: (scope, elem, attrs, ngClick) ->
    elem.bind 'click', (e) ->
      e.preventDefault()
      false

