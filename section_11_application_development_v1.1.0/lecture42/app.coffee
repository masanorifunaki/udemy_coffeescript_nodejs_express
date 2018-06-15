accesslogger = require './lib/log/accsesslogger.coffee'
systemlogger = require './lib/log/systemlogger.coffee'
express = require 'express'
bodyParser = require 'body-parser'
app = express()


app.set 'view engine', 'pug'
app.disable 'x-powered-by'

app.use('/public', express.static(__dirname + '/public/development'))

# `app.use('/public', express.static(__dirname + '/public/' + (process.env.NODE_ENV === 'development' ? 'development' : 'production')));`

app.use accesslogger()

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.use '/', require './routes/index.coffee'
app.use '/posts/', require './routes/posts.coffee'
app.use '/search/', require './routes/search.coffee'
app.use '/account/', require './routes/account.coffee'

app.use systemlogger()


# application log用
# logger = require('./lib/log/logger.coffee').application
# logger.addContext 'key', 'test'
# logger.error 'message'

app.listen 3000