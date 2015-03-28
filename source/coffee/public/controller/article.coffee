'use strict'

app = angular.module 'blog'

words = ['静如面瘫', '动如癫痫', '陌上花开', '可缓缓归']


app.controller 'ArticleListCtr', ['$scope', 'Article', '$rootScope', ($scope, Article, $rootScope)->
    Article.fetchArticles().then (results)->
        $scope.articles = results

    # 偷一下懒，就不整麻烦的分页了
    $scope.more = ->
        Article.fetchArticles($scope.articles.length).then (results)->
            if results
                $scope.articles.push.apply $scope.articles, results

    $rootScope.$emit 'changeHeader', {
        title: '雲神'
        subtitle: 'We do what we must, becase we can! （＾ν＾）'
        img: 'home-bg.jpg'
    }
]

app.controller 'ArticleDetailCtr', ['$scope', 'Article', '$stateParams', '$state', '$location', '$rootScope',
($scope, Article, $stateParams, $state, $location, $rootScope)->

    $scope.hasLogin = if AV.User.current() then true else false

    $rootScope.wordIndex = $rootScope.wordIndex || 0

    if $stateParams.art
        $scope.article = $stateParams.art
        $scope.title = $scope.article.get 'title'
        $scope.content = $scope.article.get 'content'
        window.disqus_identifier = $scope.article.id
        window.disqus_url = $location.absUrl()

        $rootScope.$emit 'changeHeader', {
            title: words[$rootScope.wordIndex % words.length]
            subtitle: $scope.title
            img: 'post-sample-image.jpg'
        }

        $rootScope.wordIndex += 1
    else
        Article.getArticle($stateParams.articleId).then (article)->
            $scope.article = article
            $scope.title = $scope.article.get 'title'
            $scope.content = $scope.article.get 'content'
            window.disqus_identifier = $scope.article.id
            window.disqus_url = $location.absUrl()

            $rootScope.$emit 'changeHeader', {
                title: words[$rootScope.wordIndex % words.length]
                subtitle: $scope.title
                img: 'post-sample-image.jpg'
            }
        $rootScope.wordIndex += 1

    $scope.goEdit = ->
        $state.go 'post', {art: $scope.article}


]

app.controller 'ArticlePostCtr', ['$scope', 'Global', '$stateParams', '$state', '$rootScope',
($scope, Global, $stateParams, $state, $rootScope)->
    if not AV.User.current()
        $state.go 'home'
        return
    $scope.article = $stateParams.art || new Global.article()
    $scope.title = $scope.article.get('title') || ''
    $scope.content = $scope.article.get('content') || ''

    $scope.alert = {
        show: false
        type: 'danger'
        msg: ''
    }
    $scope.save = ->
        if not $scope.title
            $scope.alert.show = true
            $scope.alert.type = 'danger'
            $scope.alert.msg = "标题不能为空"
        else if not $scope.content
            $scope.alert.show = true
            $scope.alert.type = 'danger'
            $scope.alert.msg = "正文不能为空"
        else
            $scope.article.set 'title', $scope.title
            $scope.article.set 'content', $scope.content 
            $scope.article.set 'user', AV.User.current()
            $scope.article.save null, {
                success: (ret)->
                    alert '发布成功'
                error: (ret, err)->
                    alert '发布失败-', err
            }

    $scope.changeHeader = ->
        $rootScope.$emit 'changeHeader', {
            title: '文艺'
            subtitle: $scope.title || '陌上花开，可缓缓归'
            img: 'post-bg.jpg'
        }

    $scope.changeHeader()
]