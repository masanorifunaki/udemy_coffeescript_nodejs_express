express = require "express"
app = express()
app.get "/", (req, res) ->
  res.status(200).send "Hello World"

app.listen 3000