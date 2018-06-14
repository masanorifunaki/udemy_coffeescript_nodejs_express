express = require "express"
app = express()
logger = require("./lib/log/logger.coffee").console

app.set "view engine", "pug"
app.disable "x-powered-by"

app.use("/public", express.static(__dirname + "/public/development"))

# `app.use("/public", express.static(__dirname + "/public/" + (process.env.NODE_ENV === "development" ? "development" : "production")));`

app.use "/", require "./routes/index.coffee"

app.listen 3000