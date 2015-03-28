'use strict'

app = angular.module 'blog'

app.controller 'LoginCtr', ['$scope', '$modalInstance', '$state', 
($scope, $modalInstance, $state)->
    $scope.login = ->
        if $scope.username and $scope.passwd
            AV.User.logIn $scope.username, $scope.passwd, {
                success: (user)->
                    $modalInstance.close user
                error: (user, err)->
                    alert '登录失败' + err
            }
        else
            alert '用户名和密码不能为空'
    $scope.cancel = ->
        $modalInstance.dismiss 'cancel'
]

app.controller 'AboutCtr', ['$scope', ($scope)->
]