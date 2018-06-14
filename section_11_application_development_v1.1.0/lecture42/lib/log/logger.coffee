log4js = require "log4js"
config = require "../../config/log4js.config.coffee"

log4js.configure config
console = log4js.getLogger()

module.exports = {
  console
}