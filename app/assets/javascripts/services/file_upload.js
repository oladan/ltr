angular.module('ltrApp')
  .service('fileUpload', ['$http', function ($http) {
    this.uploadFileToUrl = function(file, pictures, data, uploadUrl, saveMethod, response){
      var fd = new FormData();

      // Append additional parametters
      for (var k in data) {
        var name = 'point['+k+']';
        fd.append(name, data[k])
      }

      // Append the avatar
      fd.append('point[avatar]', file);

      // Append the pictures
      $.each(pictures,function(j,file){
        fd.append('point[pictures]['+j+']', file);//i had to change "i" by "j"
      });

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
