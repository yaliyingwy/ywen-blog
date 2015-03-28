# [ywen blog](https://ywen.avosapps.com/)

[ywen Blog](https://ywen.avosapps.com/)是从[clean-blog](https://github.com/IronSummitMedia/startbootstrap-clean-blog) fork过来，搭建在[leancloud](https://leancloud.cn)上的免费博客。

## 如何使用？

成功运行这个项目需要以下步骤：

* 去[leancloud](https://leancloud.cn)上面注册账号，在控制台创建你的应用，并到云代码的设置里设置好域名。
* 参考[云代码工具文档](https://leancloud.cn/docs/cloud_code_commandline.html)安装命令行工具
* 安装[node](https://nodejs.org/download/),[bower](http://bower.io)和[grunt](http://www.gruntjs.org)
* 在项目根目录下执行以下命令安装依赖包
>        npm install
>
>        bower install

* 在leancloud上你的应用设置里找到应用的id和key,填入source/config/global.json和source/coffee/cloud/app.coffee里

* 启动项目
>        grunt default

