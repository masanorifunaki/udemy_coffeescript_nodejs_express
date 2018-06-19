SESSION_SECRET = require('./config/app.config.coffee').security.SESSION_SECRET
accesslogger = require './lib/log/accsesslogger.coffee'
systemlogger = require './lib/log/systemlogger.coffee'
express = require 'express'
bodyParser = require 'body-parser'
initialize = require('./lib/security/accountcontrol.coffee').initialize
authenticate = require('./lib/security/accountcontrol.coffee').authenticate
authorize = require('./lib/security/accountcontrol.coffee').authorize
cookieParser = require 'cookie-parser'
session = require 'express-session'
flash = require 'connect-flash'
app = express()


app.set 'view engine', 'pug'
app.disable 'x-powered-by'

app.use '/public', express.static __dirname + '/public/development'

app.use accesslogger()

app.use cookieParser()
app.use session(
  secret: SESSION_SECRET
  resave: false
  saveUninitialized: true
  name: 'sid'
)

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use flash()
for i in initialize()
  app.use i

app.use '/api', do ->
  router = express.Router()
  router.use '/posts', require './api/posts.coffee'
  return router

app.use '/', do ->
  router = express.Router()
  router.use (req, res, next) ->
    res.setHeader 'X-Frame-Options', 'SAMEORIGIN'
    next()
  router.use '/posts/', require './routes/posts.coffee'
  router.use '/search/', require './routes/search.coffee'
  router.use '/account/', require './routes/account.coffee'
  router.use '/', require './routes/index.coffee'
  return router

app.use systemlogger()

app.use (req, res, next) ->
  data =
    method: req.method
    protocol: req.protocol
    version: req.httpVersion
    url: req.url
  res.status 404
  if req.xhr
    res.json data
  else
    res.render './404', data

app.use (err, req, res, next) ->
  data =
    method: req.method
    protocol: req.protocol
    version: req.httpVersion
    url: req.url
    error:
      name: err.name
      message: err.message
      stack: err.stack
  res.status 500
  if req.xhr
    res.json data
  else
    res.render './500', data

# application log用
# logger = require('./lib/log/logger.coffee').application
# logger.addContext 'key', 'test'
# logger.error 'message'

app.listen 3000