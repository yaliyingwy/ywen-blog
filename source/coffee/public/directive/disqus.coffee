'use strict'

app = angular.module 'blog'

app.directive 'disqus', ->
    {
        restrict: 'A'
        template: '<div id="disqus_thread"></div>'
        scope: {
            shortname: '@'
        }
        link: ($scope, $elem, $attrs)->
            script = document.createElement 'script'
            script.type = 'text/javascript'
            script.async = true
            script.src = '//' + 'shortname' + '.disqus.com/embed.js'

            $elem.append angular.element(script)

    }
