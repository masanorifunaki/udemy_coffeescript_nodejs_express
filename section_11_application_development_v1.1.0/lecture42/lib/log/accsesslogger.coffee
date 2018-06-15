log4js = require "log4js"
logger = require("./logger.coffee").access

module.exports = (options) ->
  options = options || {}
  options.level = options.level || "auto"
  return log4js.connectLogger logger, options
