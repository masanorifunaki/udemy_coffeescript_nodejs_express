message = "外側"

test = ->
  `var message`
  message = '関数内'
  console.log '1:' + message
  msg = ->
    `var message`
    message = 'ブロック内（関数内）'
    console.log '2:' + message
  msg()
  console.log '3:' + message

test()

console.log '4:' + message
