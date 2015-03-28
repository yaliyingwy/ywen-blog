(function() {
  'use strict';
  var app, express, leancloud, swig;

  express = require('express');

  app = express();

  swig = require('swig');

  leancloud = {
    "applicationName": "ywen_blog",
    "applicationId": "hi9fqobjlnjb93zqui5r31iu52z0ps5i7oj8om7l5zc09by4",
    "applicationKey": "qmbdipc4vy1k1z3bladzk83gd5atlt2697v1l01nv6v46af6",
    "global": {
      "avVersion": "0.3.1"
    }
  };

  app.engine('html', swig.renderFile);

  app.set('views', 'cloud/views');

  app.set('view engine', 'html');

  app.use(express.bodyParser());

  app.get('/', function(req, res) {
    return res.render('index', {
      leancloud: leancloud
    });
  });

  app.listen();

}).call(this);
