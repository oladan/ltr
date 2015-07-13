angular.module('ltrApp')
  .service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function(file, data, uploadUrl, saveMethod, response){
      var fd = new FormData();

      // Append additional parametters
      for (var k in data) {
        var name = 'point['+k+']';
        fd.append(name, data[k])
      }

      // Append the file
      fd.append('point[avatar]', file);

      saveMethod(uploadUrl, fd, {
        transformRequest: angular.identity,
        headers: {'Content-Type': undefined}
      })
      .success(function(response){
        top.location.href="/dashboard";
      })
      .error(function(response){
        // callback(response);
      });
    }
  }]);
