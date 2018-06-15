CONNECTION_URL = require('../config/monogodb.config.coffee').CONNECTION_URL
DATABSE = require('../config/monogodb.config.coffee').DATABSE
OPTIONS = require('../config/monogodb.config.coffee').OPTIONS
MongoClient = require('mongodb').MongoClient
router = require('express').Router()

router.get '/*', (req, res) ->
  MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
    db = client.db DATABSE
    db.collection('posts').findOne(
      url: req.url
    ).then((doc) ->
      doc =
        doc: doc
      res.render './posts/index', doc
    ).catch((error) ->
      throw error
    ).then ->
      client.close()

module.exports = router