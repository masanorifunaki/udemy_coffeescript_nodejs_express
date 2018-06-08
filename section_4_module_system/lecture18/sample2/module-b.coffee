config = require "./module-config.coffee"

config.display.fontColor = "green"

module.exports = ->
  console.log config.display.fontColor