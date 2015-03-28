'use strict'

app = angular.module 'blog'

app.factory 'Article', ['Global', '$q', (Global, $q)->
    {
        fetchArticles: (skip)->
            query = new AV.Query Global.article
            query.limit 10
            query.skip skip
            query.include 'user'
            deferred = $q.defer()

            query.find {
                success: (results)->
                    deferred.resolve results
                error: (error)->
                    deferred.reject error
            }
            return deferred.promise

        getArticle: (articleId)->
            query = new AV.Query Global.article
            query.include 'user'
            deferred = $q.defer()
            query.get articleId, {
                success: (result)->
                    deferred.resolve result
                error: (result, error)->
                    deferred.reject error
            }
            return deferred.promise
    }
]