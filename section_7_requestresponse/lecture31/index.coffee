express = require "express"
app = express()

app.set "view engine", "pug"

app.get "/", (req, res) ->
  console.log req.query
  res.render "index"

app.listen 3000