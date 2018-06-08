console.log "module A start."

console.log "module B loading..."

require "./module-b.coffee"

console.log "module B loaded."

module.exports = "Module A"