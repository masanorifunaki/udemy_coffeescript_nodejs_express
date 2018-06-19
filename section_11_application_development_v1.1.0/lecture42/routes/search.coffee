MAX_ITEMS_PER_PAGE = require('../config/app.config.coffee').search.MAX_ITEM_PER_PAGE
CONNECTION_URL = require('../config/monogodb.config.coffee').CONNECTION_URL
DATABSE = require('../config/monogodb.config.coffee').DATABSE
OPTIONS = require('../config/monogodb.config.coffee').OPTIONS
MongoClient = require('mongodb').MongoClient
router = require('express').Router()

router.get '/*', (req, res) ->
  page = if req.query.page then req.query.page - 0 else 1
  keyword = req.query.keyword || ''
  regexp = new RegExp ".*#{keyword}.*"
  # {} の省略不可
  query =
    $or: [
      { title: regexp }
      { content: regexp }
    ]
  MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
    db = client.db DATABSE
    Promise.all [
      db.collection 'posts'
        .find query
        .count()
      db.collection 'posts'
        .find query
        .sort published: -1
        .skip (page - 1) * MAX_ITEMS_PER_PAGE
        .limit MAX_ITEMS_PER_PAGE
        .toArray()
    ]
    .then (results) ->
      data =
        keyword: keyword
        count: results[0]
        lists: results[1]
        pagination:
          max: Math.ceil results[0] / MAX_ITEMS_PER_PAGE
          current: page
      res.render './search/list', data
    .catch (error) ->
      throw error
    .then ->
      client.close()

module.exports = router