express = require "express"
app = express()

User = require "./router/user.coffee"

app.use "/user", User

app.listen 3000