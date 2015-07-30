angular.module('ltrApp').controller 'PointsCtrl', ['$scope', '$http', 'alerts', '$window', ($scope, $http, alerts, $window) ->
  $scope.points = []
  $scope.pointFilter =
    price_from: null
    price_to: null
    city_filt: null
    country_filt: null
    address_filt: null

  prepareFilter = ->
    $scope.pointFilter[key] = $scope.pointFilter[key] || null for key of $scope.pointFilter

  fetchPoints = ->
    $('#myModal').show()
    $http.get('/api/points', params: $scope.pointFilter)
      .success (data) ->
        $scope.points = data
        $('#myModal').hide()
      .error ->
        alerts.addAlert('danger', 'Failed to load points.')

  $scope.filterPoints = (filter) ->
    return unless $scope.formPointsFilter.$valid
    prepareFilter()
    fetchPoints()

  $scope.deletePoint = (point) ->
    return unless $window.confirm("Are you sure you want to delete this point?")
    $http.delete("/api/points/#{point.id}")
      .success ->
        $scope.points.splice $scope.points.indexOf(point), 1
      .error ->
        alerts.addAlert('danger', 'Failed to delete the point.')

  fetchPoints()
]
