(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.directive('disqus', function() {
    return {
      restrict: 'A',
      template: '<div id="disqus_thread"></div>',
      scope: {
        shortname: '@'
      },
      link: function($scope, $elem, $attrs) {
        var script;
        script = document.createElement('script');
        script.type = 'text/javascript';
        script.async = true;
        script.src = '//' + 'shortname' + '.disqus.com/embed.js';
        return $elem.append(angular.element(script));
      }
    };
  });

}).call(this);
