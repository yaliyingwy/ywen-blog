'use strict'
angular.element(document).ready ->
    angular.bootstrap document, ['blog']

app = angular.module 'blog', ['ui.router', 'Showdown', 'ui.bootstrap']

app.config ['$ShowdownProvider', ($ShowdownProvider)->
    $ShowdownProvider.loadExtension 'prettify'
    $ShowdownProvider.loadExtension 'table'
    $ShowdownProvider.loadExtension 'github'
]


app.config ['$locationProvider', ($locationProvider)->
    $locationProvider.hashPrefix '!'
]


AV.initialize window.appId, window.appKey
AV.User.logOut()


