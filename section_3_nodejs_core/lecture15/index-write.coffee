fs = require "fs"

data = "こんにちは"

fs.writeFile "./data/hello.txt", data, (error) ->
  if error
    console.log error.message

  console.log "書き込み完了"