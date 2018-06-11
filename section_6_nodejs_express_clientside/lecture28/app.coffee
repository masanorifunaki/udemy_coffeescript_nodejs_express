express = require "express"
app = express()

app.set "view engine", "pug"

Router = require "./routes/index.coffee"

app.use "/public", express.static __dirname + "/public"
app.use "/", Router

app.listen 3000