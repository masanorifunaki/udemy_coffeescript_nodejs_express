CONNECTION_URL = require('../config/mongodb.config.coffee').CONNECTION_URL
DATABASE = require('../config/mongodb.config.coffee').DATABASE

router = require('express').Router()
MongoClient = require('mongodb').MongoClient

router.get '/*', (req, res) ->
  MongoClient.connect CONNECTION_URL, (err, client) ->
    if err
      throw err

    db = client.db DATABASE

    db.collection 'posts'
      .findOne url: { $eq: req.url }
      .then (post) ->
        if post
          res.json post
        else
          res.status(404).json()
      .catch (err) ->
        res.json err
      .then ->
        client.close()

module.exports = router