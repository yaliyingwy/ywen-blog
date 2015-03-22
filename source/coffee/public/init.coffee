'use strict'

angular.element(document).ready ->
    angular.bootstrap document, 'blog'

packageModules = []

for m in window.modules
    angular.module m.module, m.angularDependencies || []
    packageModules.push m.module

angular.module 'blog.articles', []

modules = ['ngResource', 'ui.router', 'blog.articles']
modules = modules.concat packageModules

angular.module 'blog', modules