(function() {
  'use strict';
  var i, len, m, modules, packageModules, ref;

  angular.element(document).ready(function() {
    return angular.bootstrap(document, 'blog');
  });

  packageModules = [];

  ref = window.modules;
  for (i = 0, len = ref.length; i < len; i++) {
    m = ref[i];
    angular.module(m.module, m.angularDependencies || []);
    packageModules.push(m.module);
  }

  angular.module('blog.articles', []);

  modules = ['ngResource', 'ui.router', 'blog.articles'];

  modules = modules.concat(packageModules);

  angular.module('blog', modules);

}).call(this);
