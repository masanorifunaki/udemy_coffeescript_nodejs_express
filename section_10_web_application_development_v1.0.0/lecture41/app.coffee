express = require "express"
accesslogger = require "./lib/logger/accesslogger.coffee"
systemlogger = require "./lib/logger/systemlogger.coffee"
bodyParser = require "body-parser"
app = express()

app.set "view engine", "pug"

app.use "/public", express.static __dirname + "/public"

app.use accesslogger()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.use "/", require "./routes/index.coffee"
app.use "/post", require "./routes/post.coffee"
app.use "/search", require "./routes/search.coffee"
app.use "/account", require "./routes/account.coffee"

app.use systemlogger()

app.listen 3000