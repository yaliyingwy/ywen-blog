(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.factory('Global', function() {
    var global;
    global = {};
    global.article = AV.Object.extend('Article');
    global.user = AV.Object.extend('_User');
    return global;
  });

}).call(this);
