config = require "./module-config.coffee"

config.display.fontColor = "blue"

module.exports = ->
  console.log config.display.fontColor