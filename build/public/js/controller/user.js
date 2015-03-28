(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.controller('LoginCtr', [
    '$scope', '$modalInstance', '$state', function($scope, $modalInstance, $state) {
      $scope.login = function() {
        if ($scope.username && $scope.passwd) {
          return AV.User.logIn($scope.username, $scope.passwd, {
            success: function(user) {
              return $modalInstance.close(user);
            },
            error: function(user, err) {
              return alert('登录失败' + err);
            }
          });
        } else {
          return alert('用户名和密码不能为空');
        }
      };
      return $scope.cancel = function() {
        return $modalInstance.dismiss('cancel');
      };
    }
  ]);

  app.controller('AboutCtr', ['$scope', function($scope) {}]);

}).call(this);
