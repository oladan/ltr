angular.module('ltrApp').controller 'PointCtrl', ['$scope', '$http', 'alerts', '$filter', '$location', '$routeParams', ($scope, $http, alerts, $filter, $location, $routeParams) ->
  if $routeParams.pointId
    $scope.point = {id: $routeParams.pointId}

    $http.get("/api/points/" + $routeParams.pointId)
      .success (data) ->
        data.eaten_at = new Date(data.eaten_at)
        data.date = $filter('date')(data.eaten_at, 'yyyy-MM-dd', 'UTC')
        data.time = $filter('date')(data.eaten_at, 'H:mm', 'UTC')
        $scope.point = data
      .error ->
        alerts.addAlert('danger', "Failed to load the point.")
  else
    now = new Date()
    $scope.point =
      eaten_at: now
      date: $filter('date')(now, 'yyyy-MM-dd', 'UTC')
      time: $filter('date')(now, 'H:mm', 'UTC')

  $scope.savePoint = (point) ->
    return if $scope.formPoint.$invalid
    pointAttr = 
      title: point.title
      price: point.price
      place: point.place
  
    saveMethod = if point.id then $http.patch else $http.post
    saveMethod((if point.id then "/api/points/#{point.id}" else "/api/points/"), pointAttr)
      .success (data) ->
        $location.path('/dashboard')
      .error (data, status, headers, config) ->
        if status == 422 and data.errors
          alerts.addAlert 'danger', "Please fix the following errors: #{data.errors.join(', ')}."
        else
          alerts.addAlert 'danger', 'Failed to save point.'
]
