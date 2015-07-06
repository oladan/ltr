compareTo = ->
  require: "ngModel"
  scope:
    otherModelValue: "=compareTo"

  link: (scope, element, attributes, ngModel) ->
    ngModel.$validators.compareTo = (modelValue) ->
      modelValue is scope.otherModelValue

    scope.$watch "otherModelValue", ->
      ngModel.$validate()
      return

    return

angular.module('ltrApp').directive "compareTo", compareTo

angular.module('ltrApp').controller 'SignUpCtrl', ['$scope', '$http', '$location', 'alerts', '$rootScope', ($scope, $http, $location, alerts, $rootScope) ->
  busy = false

  $scope.signUp = (user) ->
    return if $scope.formUser.$invalid
    return if busy
    busy = true
    $http.post('/api/users', user: user)
      .success (data) ->
        $rootScope.currentUser = data.user
        $location.path('/dashboard')
      .error (data, status, headers, config) ->
        if status == 422 and data.errors
          alerts.addAlert 'danger', "Please fix the following errors: #{data.errors.join(', ')}."
        else
          alerts.addAlert 'danger', 'Failed to sign up.'        
        busy = false
]
