(function() {
  'use strict';
  var app, words;

  app = angular.module('blog');

  words = ['静如面瘫', '动如癫痫', '陌上花开', '可缓缓归'];

  app.controller('ArticleListCtr', [
    '$scope', 'Article', '$rootScope', function($scope, Article, $rootScope) {
      Article.fetchArticles().then(function(results) {
        return $scope.articles = results;
      });
      $scope.more = function() {
        return Article.fetchArticles($scope.articles.length).then(function(results) {
          if (results) {
            return $scope.articles.push.apply($scope.articles, results);
          }
        });
      };
      return $rootScope.$emit('changeHeader', {
        title: '雲神',
        subtitle: 'We do what we must, becase we can! （＾ν＾）',
        img: 'home-bg.jpg'
      });
    }
  ]);

  app.controller('ArticleDetailCtr', [
    '$scope', 'Article', '$stateParams', '$state', '$location', '$rootScope', function($scope, Article, $stateParams, $state, $location, $rootScope) {
      $scope.hasLogin = AV.User.current() ? true : false;
      $rootScope.wordIndex = $rootScope.wordIndex || 0;
      if ($stateParams.art) {
        $scope.article = $stateParams.art;
        $scope.title = $scope.article.get('title');
        $scope.content = $scope.article.get('content');
        window.disqus_identifier = $scope.article.id;
        window.disqus_url = $location.absUrl();
        $rootScope.$emit('changeHeader', {
          title: words[$rootScope.wordIndex % words.length],
          subtitle: $scope.title,
          img: 'post-sample-image.jpg'
        });
        $rootScope.wordIndex += 1;
      } else {
        Article.getArticle($stateParams.articleId).then(function(article) {
          $scope.article = article;
          $scope.title = $scope.article.get('title');
          $scope.content = $scope.article.get('content');
          window.disqus_identifier = $scope.article.id;
          window.disqus_url = $location.absUrl();
          return $rootScope.$emit('changeHeader', {
            title: words[$rootScope.wordIndex % words.length],
            subtitle: $scope.title,
            img: 'post-sample-image.jpg'
          });
        });
        $rootScope.wordIndex += 1;
      }
      return $scope.goEdit = function() {
        return $state.go('post', {
          art: $scope.article
        });
      };
    }
  ]);

  app.controller('ArticlePostCtr', [
    '$scope', 'Global', '$stateParams', '$state', '$rootScope', function($scope, Global, $stateParams, $state, $rootScope) {
      if (!AV.User.current()) {
        $state.go('home');
        return;
      }
      $scope.article = $stateParams.art || new Global.article();
      $scope.title = $scope.article.get('title') || '';
      $scope.content = $scope.article.get('content') || '';
      $scope.alert = {
        show: false,
        type: 'danger',
        msg: ''
      };
      $scope.save = function() {
        if (!$scope.title) {
          $scope.alert.show = true;
          $scope.alert.type = 'danger';
          return $scope.alert.msg = "标题不能为空";
        } else if (!$scope.content) {
          $scope.alert.show = true;
          $scope.alert.type = 'danger';
          return $scope.alert.msg = "正文不能为空";
        } else {
          $scope.article.set('title', $scope.title);
          $scope.article.set('content', $scope.content);
          $scope.article.set('user', AV.User.current());
          return $scope.article.save(null, {
            success: function(ret) {
              return alert('发布成功');
            },
            error: function(ret, err) {
              return alert('发布失败-', err);
            }
          });
        }
      };
      $scope.changeHeader = function() {
        return $rootScope.$emit('changeHeader', {
          title: '文艺',
          subtitle: $scope.title || '陌上花开，可缓缓归',
          img: 'post-bg.jpg'
        });
      };
      return $scope.changeHeader();
    }
  ]);

}).call(this);
