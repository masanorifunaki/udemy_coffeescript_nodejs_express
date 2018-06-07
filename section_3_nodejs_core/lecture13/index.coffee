util = require "util"

class Animal
  constructor: ->
    @message = "qwert"
  say: ->
    console.log "#{@message}"

class Dog
  constructor: ->
    @message = "わんわん"

util.inherits Dog, Animal

dog = new Dog()
dog.say()
