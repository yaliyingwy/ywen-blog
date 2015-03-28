'use strict'

express = require 'express'
app = express()

swig = require 'swig'

leancloud = {
    "applicationName" : "ywen_blog",
    "applicationId": "your id",
    "applicationKey": "your key",
    "global": {
        "avVersion": "0.3.1"
    }
}

app.engine 'html', swig.renderFile
app.set 'views', 'cloud/views'
app.set 'view engine', 'html'
app.use express.bodyParser()


app.get '/', (req, res)->
    res.render 'index', {leancloud: leancloud}


app.listen()
