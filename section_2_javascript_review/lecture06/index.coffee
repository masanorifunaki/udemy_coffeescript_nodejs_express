MAX_COUNT = 10
write = (value) ->
  $('#result').append "<span class='badge'>#{value}</span>"

btnExec1_onclick = (event) ->
  start = (new Date).getTime()
  now = null
  n = 0
  loop
    now = (new Date).getTime()
    time = now - (start + n * 1000)
    if time > 1000
      write ++n
    unless n < MAX_COUNT
       break

btnExec2_onclick = (event) ->
  n = 0
  callback = ->
    window.setTimeout (->
      write ++n
      if n < MAX_COUNT
        callback()
    ), 1000
  callback()

btnClear_onclick = (event) ->
  $('#result').empty()

$(document).ready ->
  $('#btn_exec_1').on 'click', btnExec1_onclick
  $('#btn_exec_2').on 'click', btnExec2_onclick
  $('#btn_clear').on 'click', btnClear_onclick

