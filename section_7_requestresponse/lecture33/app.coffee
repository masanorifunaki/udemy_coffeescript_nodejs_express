express = require "express"
cookieParser = require "cookie-parser"
app = express()

app.set "view engine", "pug"

app.use cookieParser()

app.get "/", (req, res) ->
  count = parseInt req.cookies.count || 0
  res.cookie "count", count + 1
  res.render "index", count: count

app.listen 3000