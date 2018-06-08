http = require "http"
server = http.createServer()

server.on "request", (request, response) ->
  # レスポンスの作成
  data = "Hello World"
  response.writeHead 200,
    "Content-Length": Buffer.byteLength data
    "Content-Type": "text/plain"
  response.write data, "utf8"
  response.end()

server.listen 3000
