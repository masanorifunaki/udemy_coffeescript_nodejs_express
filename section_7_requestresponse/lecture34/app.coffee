express = require "express"
session = require "express-session"
app = express()

app.set "view engine", "pug"

app.use session
  secret: "qwerty",
  resave: false,
  saveUninitialized: true,
  name: "sid"

app.get "/", (req, res) ->
  count = req.session.count || 0
  req.session.count = count + 1
  res.render "index",
    count: count

app.listen 3000

