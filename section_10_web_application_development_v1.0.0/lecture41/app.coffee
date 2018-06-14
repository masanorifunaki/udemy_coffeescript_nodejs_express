SESSION_SECRET = require("./config/app.config.coffee").security.SESSION_SECRET
express = require "express"
accesslogger = require "./lib/logger/accesslogger.coffee"
systemlogger = require "./lib/logger/systemlogger.coffee"
initialize = require("./lib/security/accountcontrol.coffee").initialize

cookieParser = require "cookie-parser"
session = require "express-session"
flash = require "connect-flash"
bodyParser = require "body-parser"
app = express()

app.disable "x-powered-by"
app.set "view engine", "pug"

app.use "/public", express.static __dirname + "/public"

app.use accesslogger()
app.use cookieParser()
app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()
app.use flash()
app.use session(
  secret: SESSION_SECRET,
  resave: false,
  saveUninitialized: true,
  name: "sid"
)

for i in initialize()
  app.use i

app.use "/", require "./routes/index.coffee"
app.use "/post", require "./routes/post.coffee"
app.use "/search", require "./routes/search.coffee"
app.use "/account", require "./routes/account.coffee"
app.use "/api/post", require "./api/post.coffee"

app.use systemlogger()

app.listen 3000