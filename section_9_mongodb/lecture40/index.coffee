MongoClient = require("mongodb").MongoClient

url = "mongodb://localhost:27017/"

MongoClient.connect url, (error, client) ->
  db = client.db "sample"
  # ドキュメント作成
  db.collection "product", (error, collection) ->
    collection.insertMany([
      name: "pen", price: 120,
      name: "note", price: 100,
      name: "coffee", price: 300,
    ]).then( ->
      # ドキュメント更新
      collection.updateMany
          name: /e/g,
          { $inc:
            price: 20 }
    ).then ->
      # ドキュメント検索
      collection
        .find(name : $regex: /e/g)
        .forEach (item) ->
          console.log item.name
        (error) ->
          client.close()

