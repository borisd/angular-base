angular.module("routes", [])
  .config(['$stateProvider', '$urlRouterProvider', '$logProvider', '$httpProvider',
    ($stateProvider, $urlRouterProvider, $logProvider, $httpProvider) ->

      $urlRouterProvider.otherwise "/"

      $logProvider.debugEnabled true

      $httpProvider.interceptors.push "httpInterceptor"

      $stateProvider
        .state "auth",
          url: ""
          abstract: true
          template: "<div ui-view></div>"
        .state "apps",
          url: "/apps"
          abstract: true
          template: "<div ui-view></div>"
  ])
