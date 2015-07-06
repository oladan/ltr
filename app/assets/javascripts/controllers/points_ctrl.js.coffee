angular.module('ltrApp').controller 'PointsCtrl', ['$scope', '$http', 'alerts', '$window', ($scope, $http, alerts, $window) ->
  $scope.points = []
  $scope.caloriesDaily = []
  $scope.pointFilter =
    date_from: null
    date_to: null
    time_from: null
    time_to: null

  prepareFilter = ->
    $scope.pointFilter[key] = $scope.pointFilter[key] || null for key of $scope.pointFilter

  fetchPoints = ->
    $http.get('/api/points', params: $scope.pointFilter)
      .success (data) ->
        $scope.points = data
      .error ->
        alerts.addAlert('danger', 'Failed to load points.')

  fetchCaloriesDaily = ->
    $http.get('/api/calories_daily', params: $scope.pointFilter)
      .success (data) ->
        $scope.caloriesDaily = data
      .error ->
        alerts.addAlert('danger', 'Failed to calories daily.')        

  $scope.filterPoints = (filter) ->
    return unless $scope.formFilter.$valid
    prepareFilter()
    fetchPoints()
    fetchCaloriesDaily()

  $scope.deletePoint = (point) ->
    return unless $window.confirm("Are you sure you want to delete this point?")
    $http.delete("/api/points/#{point.id}")
      .success ->
        $scope.points.splice $scope.points.indexOf(point), 1
        fetchCaloriesDaily()
      .error ->
        alerts.addAlert('danger', 'Failed to delete the point.')

  fetchPoints()
  fetchCaloriesDaily()
]
