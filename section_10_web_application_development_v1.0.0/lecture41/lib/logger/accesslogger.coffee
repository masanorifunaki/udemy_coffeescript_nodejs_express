log4js = require "log4js"
logger = require "./logger.coffee"

module.exports = (options) ->
  options = options || level: "auto"
  return log4js.connectLogger logger.access, options