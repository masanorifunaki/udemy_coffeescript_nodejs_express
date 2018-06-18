log4js = require 'log4js'
levels = require('log4js/lib/levels.js')()

# Initialize log4js configuration.
log4js.configure './config/log4js.config.json'

# Get logger.
system = log4js.getLogger 'system'
application = log4js.getLogger 'application'
access = log4js.getLogger 'access'

# Modify applicaiton logger's log output methods.
for level of levels.levels
  level = level.toLowerCase()

  application[level] = (id, message) ->
    if !message
      message = id
      id = 'application'

    application.addContext 'functionId', id
    proto = Object.getPrototypeOf applicaiton
    proto[level].call application, message

# Exports module
module.exports = {
  log4js,
  system,
  application,
  access
}

