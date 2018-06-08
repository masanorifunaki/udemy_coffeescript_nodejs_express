console.log "module B start."

console.log "module A loading..."

require "./module-a.coffee"

console.log "module A loaded."

module.exports = "Module B"