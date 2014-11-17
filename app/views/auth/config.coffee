angular.module('views.auth', ['services'])
  .config ($stateProvider) ->
    $stateProvider.state("auth.sign_in",
      url: "/sign_in"
      controller: "SignInController"
      templateUrl: "views/auth/sign_in.html"
    )
