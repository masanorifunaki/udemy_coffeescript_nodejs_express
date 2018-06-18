PASSWORD_SALT = require('../../config/app.config.coffee').security.PASSWORD_SALT
PASSWORD_STRETCH = require('../../config/app.config.coffee').security.PASSWORD_STRETCH

crypto = require 'crypto'

digest = (text) ->
  text += PASSWORD_SALT

  i = PASSWORD_STRETCH
  while i--
    hash = crypto.createHash('sha256')
    hash.update text
    text = hash.digest('hex')

  return text

module.exports =
  digest: digest