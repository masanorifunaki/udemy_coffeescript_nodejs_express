express = require "express"
app = express()

app.set "view engine", "pug"

app.get "/", (req, res) ->
  res.status(200).render "index", title: "Webアプリケーション開発"

app.listen 3000