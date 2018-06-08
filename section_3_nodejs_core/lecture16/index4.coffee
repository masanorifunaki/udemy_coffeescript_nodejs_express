http = require "http"
server = http.createServer()

server.on "request", (request, response) ->

  data = ""
  # リクエストの分析
  console.log "METHOD: #{request.method}"
  console.log "URL: #{request.url}"
  console.log "HEADER:"
  for key of request.headers
    console.log "#{key}: #{request.headers[key]}"
  request.on "data", (chunk) ->
    data += chunk
  request.on "end", ->
    console.log data

  # レスポンスの作成
  response.end "OK"
server.listen 3000
