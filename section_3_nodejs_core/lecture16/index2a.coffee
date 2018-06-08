http = require "http"

http.createServer((request, response) ->
  response.writeHead 200, "Content-Type': 'text/plain"
  response.write "Hello World 2.", "utf8"
  response.end()
).listen 3000