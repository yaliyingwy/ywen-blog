(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.config([
    '$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $urlRouterProvider.otherwise('/');
      return $stateProvider.state('home', {
        url: '/?page',
        templateUrl: '/views/home.html'
      }).state('article', {
        url: '/article/:articleId',
        templateUrl: '/views/article.html',
        params: {
          art: null
        }
      }).state('contact', {
        url: '/contact',
        templateUrl: 'views/contact.html'
      }).state('post', {
        url: '/post',
        templateUrl: 'views/post.html',
        params: {
          art: null
        }
      });
    }
  ]);

}).call(this);
