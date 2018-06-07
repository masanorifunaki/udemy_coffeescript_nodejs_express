p1 = new Promise (resolve, reject) ->
  setTimeout (->
    reject "Hello Worlds."
  ), 100

p1.then (value) ->
  console.log '.then() onfullfiled : ' + value
, (reason) ->
  console.log '.then() onrejected : ' + reason

p1.catch (reason) ->
  console.log '.catch() onrejected : ' + reason
