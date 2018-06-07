class Animal
  constructor: ->
  say: -> "......"

class Dog extends Animal
  say: -> "わんわん"

dog = new Dog
console.log dog.say()