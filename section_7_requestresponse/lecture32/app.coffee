express = require "express"
app = express()

app.set "view engine", "pug"

app.get "/", (req, res) ->
  console.log req.get "user-agent"
  res.set "Cache-Control", "no-cache"
  res.set "Pragma", "no-cache"
  res.render "index"

app.listen 3000