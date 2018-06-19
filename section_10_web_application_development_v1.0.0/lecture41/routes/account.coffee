CONNECTION_URL = require('../config/mongodb.config.coffee').CONNECTION_URL
router = require('express').Router()
authenticate = require('../lib/security/accountcontrol.coffee').authenticate
authorize = require('../lib/security/accountcontrol.coffee').authorize
initialize = require('../lib/security/accountcontrol.coffee').initialize
MongoClient = require('mongodb').MongoClient

validate = (body) ->
  valid = true
  errors = {}

  if !body.url
    errors.url = 'URLが未入力です。'
    valid = false

  if !body.title
    errors.title = 'タイトルが未入力です。'
    valid = false

  if valid then undefined else errors

createRegistData = (body) ->

  datetime = new Date()
  data =
    url: body.url
    published: datetime
    updated: datetime
    title: body.title
    content: body.content
    keywords: if body.keywords then (body.keywords or '').split(',') else ''
    authors: if body.authors then (body.authors or '').split(',') else ''

  return data


router.get '/', authorize('owner'), (req, res) ->
  res.render 'account'

router.get '/login', (req, res) ->
  res.render 'login', message: req.flash 'message'

router.post '/login', authenticate()

router.post '/logout', authorize('owner'), (req, res) ->
  req.logout()
  res.redirect '/account/login'

router.get '/post/regist', authorize('owner'), (req, res) ->
  res.render 'regist-form'

router.post '/post/regist', authorize('owner'), (req, res) ->
  body = req.body
  errors = validate body
  original = createRegistData body

  if errors
    res.render 'regist-form', errors: errors, original: original
    return

  MongoClient.connect(CONNECTION_URL).then (db) ->
    db = db.db 'weblog'
    db.collection('posts').insertOne original
    .then (result) ->
      res.render 'regist-complete'
    .catch (err) ->
      console.log errors
      res.render 'regist-form', errors: errors, original: original

module.exports = router