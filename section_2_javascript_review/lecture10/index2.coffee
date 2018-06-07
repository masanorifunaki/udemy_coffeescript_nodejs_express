p1 = new Promise (resolve, reject) ->
  setTimeout (->
    resolve "p1 complete !"
  ), Math.random() * 3000

p2 = new Promise (resolve, reject) ->
  setTimeout (->
    resolve "p2 complete !"
  ), Math.random() * 3000

Promise.all([p1, p2]).then (value) ->
  console.log value
, (reason) ->
  console.log reason