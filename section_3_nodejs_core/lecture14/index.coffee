EventEmitter = require("events").EventEmitter
util = require "util"

class Animal
  constructor: ->
    @message = "qwert"
  say: ->
    console.log @message
    @emit "say", @message

util.inherits Animal, EventEmitter

class Dog
  constructor: ->
    @message = "わんわん"

util.inherits Dog, Animal

dog = new Dog()
dog.on "say", (message) ->
  console.log "#{message}と叫んだ"
dog.say()
