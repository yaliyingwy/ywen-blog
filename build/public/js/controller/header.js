(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.controller('HeaderCtr', [
    '$scope', '$modal', '$state', '$rootScope', function($scope, $modal, $state, $rootScope) {
      var changeTitle;
      if (AV.User.current()) {
        $scope.hasLogin = true;
      } else {
        $scope.hasLogin = false;
      }
      $scope.showLogin = function() {
        var $modalInstance;
        $modalInstance = $modal.open({
          templateUrl: 'views/login.html',
          controller: 'LoginCtr',
          size: 'sm'
        });
        return $modalInstance.result.then(function(ret) {
          $scope.hasLogin = true;
          return $state.go('post');
        });
      };
      $scope.headerInfo = {
        img: 'home-bg.jpg'
      };
      changeTitle = $rootScope.$on('changeHeader', function(event, headerInfo) {
        return $scope.headerInfo = headerInfo;
      });
      return $rootScope.$on('$destroy', function() {
        return changeTitle();
      });
    }
  ]);

}).call(this);
