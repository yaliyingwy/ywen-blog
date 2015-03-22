'use strict'

express = require 'express'
assets = require './config/assets.json'
app = express()

swig = require 'swig'


app.engine 'html', swig.renderFile
app.set 'views', 'cloud/views'
app.set 'view engine', 'html'
app.use express.bodyParser()


app.get '/index', (req, res)->
    res.render 'index', {assets: assets}


app.listen()