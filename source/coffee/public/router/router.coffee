'use strict'

app = angular.module 'blog'



app.config ['$stateProvider', '$urlRouterProvider',
    ($stateProvider, $urlRouterProvider)->
        $urlRouterProvider.otherwise '/'

        $stateProvider
        .state 'home',
        {
            url: '/?page'
            templateUrl: '/views/home.html'
        }
        .state 'article',
        {
            url: '/article/:articleId'
            templateUrl: '/views/article.html'
            params: {
                art: null
            }
        }
        # .state 'about',
        # {
        #     url: '/about'
        #     templateUrl: 'views/about.html'
        # }
        .state 'contact',
        {
            url: '/contact'
            templateUrl: 'views/contact.html'
        }
        .state 'post',
        {
            url: '/post'
            templateUrl: 'views/post.html'
            params: {
                art: null
            }
        }
]


