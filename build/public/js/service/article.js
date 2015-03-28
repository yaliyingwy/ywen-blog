(function() {
  'use strict';
  var app;

  app = angular.module('blog');

  app.factory('Article', [
    'Global', '$q', function(Global, $q) {
      return {
        fetchArticles: function(skip) {
          var deferred, query;
          query = new AV.Query(Global.article);
          query.limit(10);
          query.skip(skip);
          query.include('user');
          deferred = $q.defer();
          query.find({
            success: function(results) {
              return deferred.resolve(results);
            },
            error: function(error) {
              return deferred.reject(error);
            }
          });
          return deferred.promise;
        },
        getArticle: function(articleId) {
          var deferred, query;
          query = new AV.Query(Global.article);
          query.include('user');
          deferred = $q.defer();
          query.get(articleId, {
            success: function(result) {
              return deferred.resolve(result);
            },
            error: function(result, error) {
              return deferred.reject(error);
            }
          });
          return deferred.promise;
        }
      };
    }
  ]);

}).call(this);
