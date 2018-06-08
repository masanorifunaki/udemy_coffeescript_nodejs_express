class Square
  constructor: (@width, @height) ->
  area: ->
    @width * @height

class Triangle
  constructor: (@base, @height) ->
  area: ->
    @base * @height / 2.0

module.exports =
  Square: Square
  Triangle: Triangle