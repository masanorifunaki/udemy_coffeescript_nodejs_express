logger = require("./logger.coffee").system

module.exports = (options) ->
  return (err, req, res, next) ->
    logger.error err.message
    next err