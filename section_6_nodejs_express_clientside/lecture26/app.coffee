express = require "express"
app = express()

app.set "view engine", "pug"

app.get "/", (req, res) ->
  data = items: [
    { name: '<b>佐藤</b>' }
    { name: '鈴木' }
    { name: '高橋' }
  ]
  res.render "index", data: data

app.listen 3000