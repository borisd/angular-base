angular.module("app")
  .directive("toggleNavCollapsedMin", [
    "$rootScope"
    ($rootScope) ->
      return (
        restrict: "A"
        link: (scope, ele, attrs) ->
          app = $("#app")
          ele.on "click", (e) ->
            if app.hasClass("nav-collapsed-min")
              app.removeClass "nav-collapsed-min"
            else
              app.addClass "nav-collapsed-min"
              $rootScope.$broadcast "nav:reset"
            e.preventDefault()

          return
  )])
  .directive("collapseNav", [->
    restrict: "A"
    link: (scope, ele, attrs) ->
      $a = undefined
      $aRest = undefined
      $app = undefined
      $lists = undefined
      $listsRest = undefined
      $nav = undefined
      $window = undefined
      Timer = undefined
      prevWidth = undefined
      updateClass = undefined
      $window = $(window)
      $lists = ele.find("ul").parent("li")
      $lists.append ""
      $a = $lists.children("a")
      $listsRest = ele.children("li").not($lists)
      $aRest = $listsRest.children("a")
      $app = $("#app")
      $nav = $("#nav-container")
      $a.on "click", (event) ->
        $parent = undefined
        $this = undefined
        return false  if $app.hasClass("nav-collapsed-min") or ($nav.hasClass("nav-horizontal") and $window.width() >= 768)
        $this = $(this)
        $parent = $this.parent("li")
        $lists.not($parent).removeClass("open").find("ul").slideUp()
        $parent.toggleClass("open").find("ul").stop().slideToggle()
        event.preventDefault()
        return

      $aRest.on "click", (event) ->
        $lists.removeClass("open").find("ul").slideUp()
        return

      scope.$on "nav:reset", (event) ->
        $lists.removeClass("open").find("ul").slideUp()
        return

      Timer = undefined
      prevWidth = $window.width()
      updateClass = ->
        currentWidth = undefined
        currentWidth = $window.width()
        $app.removeClass "nav-collapsed-min"  if currentWidth < 768
        $lists.removeClass("open").find("ul").slideUp()  if prevWidth < 768 and currentWidth >= 768 and $nav.hasClass("nav-horizontal")
        prevWidth = currentWidth

      $window.resize ->
        t = undefined
        clearTimeout t
        t = setTimeout(updateClass, 300)

  ])
  .directive("highlightActive", [->
    restrict: "A"
    controller: [
      "$scope"
      "$element"
      "$attrs"
      "$location"
      ($scope, $element, $attrs, $location) ->
        highlightActive = undefined
        links = undefined
        path = undefined
        links = $element.find("a")
        path = ->
          $location.path()

        highlightActive = (links, path) ->
          path = "#" + path
          angular.forEach links, (link) ->
            $li = undefined
            $link = undefined
            href = undefined
            $link = angular.element(link)
            $li = $link.parent("li")
            href = $link.attr("href")
            $li.removeClass "active"  if $li.hasClass("active")
            $li.addClass "active"  if path.indexOf(href) is 0

          return

        highlightActive links, $location.path()
        $scope.$watch path, (newVal, oldVal) ->
          return  if newVal is oldVal
          highlightActive links, $location.path()

  ]])
  .directive "toggleOffCanvas", [->
    restrict: "A"
    link: (scope, ele, attrs) ->
      ele.on "click", ->
        $("#app").toggleClass "on-canvas"
        return

  ]
