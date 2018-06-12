express = require "express"
app = express()

app.set "view engine", "pug"

app.use "/public", express.static __dirname + "/public"

app.use "/", require "./routes/index.coffee"

app.listen 3000