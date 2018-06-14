express = require "express"
app = express()

app.set "view engine", "pug"
app.disable "x-powered-by"

app.use("/public", express.static(__dirname + "/public/development"))

# `app.use("/public", express.static(__dirname + "/public/" + (process.env.NODE_ENV === "development" ? "development" : "production")));`

app.use "/", require "./routes/index.coffee"

app.listen 3000