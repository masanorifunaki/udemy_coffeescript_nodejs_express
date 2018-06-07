class Fibonacci
  constructor: ->
    @val0 = 0
    @val1 = 1
    @timerId = undefined

  start: ->
    if @timerId
      @stop()

    @timerId = setInterval(( =>
      console.log @val0
      val2 = @val0 + @val1
      @val0 = @val1
      @val1 = val2
      ), 1000)

  stop: ->
    if @timerId
      clearInterval @timerId
      @timerId = undefined

fibonnaci = new Fibonacci
fibonnaci.start()

