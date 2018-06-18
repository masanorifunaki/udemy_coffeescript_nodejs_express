router = require('express').Router()
CONNECTION_URL = require('../config/mongodb.config.coffee').CONNECTION_URL
MongoClient = require('mongodb').MongoClient

router.get '/*', (req, res) ->
  MongoClient.connect(CONNECTION_URL).then((db) ->
    query = {
      url: { $eq: req.url }
    }
    db = db.db 'weblog'
    return db.collection('posts').findOne(query)
    ).then((data) ->
    res.render 'posts', data: data
  ).catch (err) ->
    throw err

module.exports = router