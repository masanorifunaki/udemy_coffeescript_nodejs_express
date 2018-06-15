router = require('express').Router()

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
  res.render './account/posts/regist-form.ejs', original: original

module.exports = router