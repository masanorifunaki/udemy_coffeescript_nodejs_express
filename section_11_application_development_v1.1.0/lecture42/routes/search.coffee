CONNECTION_URL = require('../config/monogodb.config.coffee').CONNECTION_URL
DATABSE = require('../config/monogodb.config.coffee').DATABSE
OPTIONS = require('../config/monogodb.config.coffee').OPTIONS
MongoClient = require('mongodb').MongoClient
router = require('express').Router()

router.get '/*', (req, res) ->
  keyword = req.query.keyword || ''


  MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
    regexp = new RegExp(".*#{keyword}.*")
    db = client.db DATABSE
    db.collection('posts')
      .find(
        # {} の省略不可
        $or: [
          { title: regexp }
          { content: regexp }
        ]
      ).sort( published: -1 ).toArray().then((list) ->
        data =
          keyword: keyword
          lists: list
        res.render './search/list', data: data
      ).catch((error) ->
        thow error
      ).then ->
        client.close()

module.exports = router