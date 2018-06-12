log4js = require "log4js"
logger = require "./logger.coffee"
system = logger.system

module.exports = (options) ->
  return (err, req, res, next) ->
    system.error err.message
    next()