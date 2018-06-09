express = require "express"
app = express()

app.use require "./lib/logger.coffee"

app.get "/", (req, res) ->
  res.status(200).send "Hello World"

app.listen 3000