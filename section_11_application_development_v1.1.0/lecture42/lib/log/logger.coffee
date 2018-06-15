log4js = require "log4js"
levels = require("log4js/lib/levels.js")().levels
config = require "../../config/log4js.config.coffee"

log4js.configure config

console = log4js.getLogger()

system = log4js.getLogger "system"

application = log4js.getLogger "application"

module.exports = {
  console,
  system,
  application
}