express = require "express"
bodyParser = require "body-parser"
app = express()

app.set "view engine", "pug"

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.get "/", (req, res) ->
  res.render "index"
app.post "/", (req, res) ->
  res.send "OK"

app.listen 3000