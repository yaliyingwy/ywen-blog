(function() {
  'use strict';
  var app;

  angular.element(document).ready(function() {
    return angular.bootstrap(document, ['blog']);
  });

  app = angular.module('blog', ['ui.router', 'Showdown', 'ui.bootstrap']);

  app.config([
    '$ShowdownProvider', function($ShowdownProvider) {
      $ShowdownProvider.loadExtension('prettify');
      $ShowdownProvider.loadExtension('table');
      return $ShowdownProvider.loadExtension('github');
    }
  ]);

  app.config([
    '$locationProvider', function($locationProvider) {
      return $locationProvider.hashPrefix('!');
    }
  ]);

  AV.initialize(window.appId, window.appKey);

}).call(this);
