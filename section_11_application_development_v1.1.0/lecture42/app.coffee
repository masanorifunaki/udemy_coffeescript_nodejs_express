systemlogger = require "./lib/log/systemlogger.coffee"
express = require "express"
app = express()


app.set "view engine", "pug"
app.disable "x-powered-by"

app.use("/public", express.static(__dirname + "/public/development"))

# `app.use("/public", express.static(__dirname + "/public/" + (process.env.NODE_ENV === "development" ? "development" : "production")));`

app.use "/", require "./routes/index.coffee"

app.use systemlogger()


# application log用
# logger = require("./lib/log/logger.coffee").application
# logger.addContext "key", "test"
# logger.error "message"

app.listen 3000