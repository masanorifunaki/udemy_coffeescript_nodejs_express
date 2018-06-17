router = require('express').Router()

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

module.exports = router