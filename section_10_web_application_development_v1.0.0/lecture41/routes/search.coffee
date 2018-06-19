MAX_ITEMS_PER_PAGE = require('../config/app.config.coffee').search.MAX_ITEMS_PER_PAGE
CONNECTION_URL = require('../config/mongodb.config.coffee').CONNECTION_URL
router = require('express').Router()
MongoClient = require('mongodb').MongoClient

router.get '/', (req, res) ->
  page = if req.query.page then parseInt(req.query.page) else 1
  keyword = req.query.keyword || ''

  MongoClient.connect(CONNECTION_URL).then (db) ->
    db = db.db 'weblog'
    regexp = new RegExp(".*#{keyword}.*")

    query =
      $or: [
        { title: regexp }
        { content: regexp }
      ]

    # 配列
    Promise.all [
      db.collection('posts').find(query).count(),
      db.collection('posts').find(query).skip((page - 1) * MAX_ITEMS_PER_PAGE).limit(MAX_ITEMS_PER_PAGE).toArray()
    ]
  .then (results) ->
    data =
      keyword: keyword
      count: results[0]
      lists: results[1]
      pagination:
        max: Math.ceil results[0] / MAX_ITEMS_PER_PAGE
        current: page

    res.render 'list', data
  .catch (err) ->
    return

module.exports = router