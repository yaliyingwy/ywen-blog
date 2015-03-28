'use strict'

app = angular.module 'blog'

app.factory 'Global', ->
    global = {}
    
    global.article = AV.Object.extend 'Article'
    global.user = AV.Object.extend '_User'
    return global