router = require('express').Router()

router.get '/', (req, res) ->
  res.render './account/index'

module.exports = router