module.exports = (req, res, next) ->
  ipaddress = req.headers["x-forwarded-for"] ||
  req.connection.remoteAddress ||
  req.socket && req.socket.remoteAddress ||
  req.connection.socket && req.connection.socket.remoteAddress ||
  "0.0.0.0"

  date = (new Date).toISOString()
  method = req.method
  url = req.url
  ua = req.headers["user-agent"]

  console.log "#{ipaddress} [#{date}] #{method} #{url} - #{ua}"

  next()