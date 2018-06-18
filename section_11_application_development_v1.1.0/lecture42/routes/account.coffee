CONNECTION_URL = require('../config/monogodb.config.coffee').CONNECTION_URL
DATABSE = require('../config/monogodb.config.coffee').DATABSE
OPTIONS = require('../config/monogodb.config.coffee').OPTIONS
MongoClient = require('mongodb').MongoClient
router = require('express').Router()
tokens = new require('csrf')()

validateRegistData = (body) ->
  isValidated = true
  errors = {}
  if !body.url
    isValidated = false
    errors.url = 'URLが未入力です。\'/\'から始まるURLを入力してください。'
  if body.url and /^\//.test(body.url) == false
    isValidated = false
    errors.url = '\'/\'から始まるURLを入力してください。'
  if !body.title
    isValidated = false
    errors.title = 'タイトルが未入力です。任意のタイトルを入力してください。'
  if isValidated then undefined else errors

# データの整形
createRegistData = (body) ->
  datetime = new Date
  {
    url: body.url
    published: datetime
    updated: datetime
    title: body.title
    content: body.content
    keywords: (body.keywords or '').split(',')
    authors: (body.authors or '').split(',')
  }

router.get '/', (req, res) ->
  res.render './account/index'

router.get '/posts/regist', (req, res) ->
  tokens.secret (error, secret) ->
    token = tokens.create secret
    req.session._csrf = secret
    res.cookie '_csrf', token
    res.render './account/posts/regist-form'

router.post '/posts/regist/input', (req, res) ->
  original = createRegistData req.body
  res.render './account/posts/regist-form', original: original


router.post '/posts/regist/confirm', (req, res) ->
  original = createRegistData(req.body)
  errors = validateRegistData(req.body)
  if errors
    res.render './account/posts/regist-form',
      errors: errors
      original: original
    return
  res.render './account/posts/regist-confirm', original: original

router.post '/posts/regist/execute', (req, res) ->

  secret = req.session._csrf
  token = req.cookies._csrf

  if tokens.verify(secret, token) == false
    throw new Error 'Invalid Token.'

  original = createRegistData(req.body)
  errors = validateRegistData(req.body)

  if errors
    res.render './account/posts/regist-form',
      errors: errors
      original: original
    return

  MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
    db = client.db DATABSE
    db.collection('posts')
    .insertOne(original)
    .then(() ->
      delete req.session._csrf
      res.clearCookie '_csrf'
      res.redirect '/account/posts/regist/complete'
    ).catch((error) ->
      throw error
    ).then ->
      client.close()

router.get '/posts/regist/complete', (req, res) ->
  res.render './account/posts/regist-complete'

module.exports = router