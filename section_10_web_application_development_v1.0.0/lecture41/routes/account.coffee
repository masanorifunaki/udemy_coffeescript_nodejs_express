CONNECTION_URL = require("../config/mongodb.config.js").CONNECTION_URL
router = require("express").Router()
MongoClient = require("mongodb").MongoClient

validate = (body) ->
  valid = true
  errors = {}

  if !body.url
    errors.url = "URLが未入力です。"
    valid = false

  if !body.title
    errors.title = "タイトルが未入力です。"
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

router.get "/", (req, res) ->
  res.render "account"

router.get "/post/regist", (req, res) ->
  res.render "regist-form"

router.post "/post/regist", (req, res) ->
  body = req.body
  errors = validate(body)
  original = createRegistData(body)

  if errors
    res.render "regist-form", errors: errors, original: original
    return

  MongoClient.connect(CONNECTION_URL).then((db) ->
    db = db.db "weblog"
    db.collection("posts").insertOne original
  ).then((result) ->
    res.render "regist-complete"
  ).catch (err) ->
    console.log errors
    res.render "regist-form", errors: errors, original: original

module.exports = router