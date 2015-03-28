'use strict'

app = angular.module 'blog'

app.controller 'HeaderCtr', ['$scope', '$modal', '$state', '$rootScope',
($scope, $modal, $state, $rootScope)->
    if AV.User.current()
        $scope.hasLogin = true
    else
        $scope.hasLogin = false
    $scope.showLogin = ->
        $modalInstance = $modal.open {
            templateUrl: 'views/login.html'
            controller: 'LoginCtr'
            size: 'sm'
        }

        $modalInstance.result.then (ret)->
            $scope.hasLogin = true
            $state.go 'post'
    
    $scope.headerInfo = {img: 'home-bg.jpg'}

    changeTitle = $rootScope.$on 'changeHeader', (event, headerInfo)->
        $scope.headerInfo = headerInfo

    $rootScope.$on '$destroy', ->
        changeTitle()

]