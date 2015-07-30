angular.module('ltrApp').controller 'PointCtrl', ['$scope', '$http', 'alerts', '$filter', '$location', '$routeParams', 'fileUpload', ($scope, $http, alerts, $filter, $location, $routeParams, fileUpload) ->

  $http.get("/points/points_types.json")
    .success (data) ->
      $scope.types_selects = data

  if $routeParams.pointId
    $scope.point = {id: $routeParams.pointId}

    $http.get("/api/points/" + $routeParams.pointId)
      .success (data) ->
        $scope.point = data
      .error ->
        alerts.addAlert('danger', "Failed to load the point.")

  $scope.savePoint = (point) ->
    $('#myModal').show()
    return if $scope.formPoint.$invalid
    pointAttr = 
      price: point.price
      place: point.place
      phone: point.phone
      type_id: point.type_id
  
    saveMethod = if point.id then $http.patch else $http.post
    if point.id then uploadUrl = "/api/points/#{point.id}" else uploadUrl = "/api/points/"
    fileUpload.uploadFileToUrl $('input[type="file"]')[0].files[0], $('input[type="file"]')[1].files, pointAttr, uploadUrl, saveMethod, (response) ->

  $scope.deletePointPhoto = (point_id, point_photo_id) ->
    return unless confirm("Are you sure you want to delete this photo?")
    $http.post('/api/points/' + point_id + '/delete_picture', point_photo_id: point_photo_id)
      .success ->
        alerts.addAlert('success', 'Selected photo succesfully removed.')
        $scope.point = {id: point_id}
        $http.get("/api/points/" + $routeParams.pointId)
          .success (data) ->
            $scope.point = data
          .error ->
            alerts.addAlert('danger', "Failed to load the point.")

      .error ->
        alerts.addAlert('danger', 'Failed to remove selected photo.')

]
