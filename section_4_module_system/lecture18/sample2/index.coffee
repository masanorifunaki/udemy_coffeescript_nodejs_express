config = require "./module-config.coffee"

console.log "index:#{config.display.fontColor}"
a = require "./module-a.coffee"

console.log "index:#{config.display.fontColor}"
b = require "./module-b.coffee"

console.log "index:#{config.display.fontColor}"
a()

console.log "index:#{config.display.fontColor}"
b()

console.log "index:#{config.display.fontColor}"
