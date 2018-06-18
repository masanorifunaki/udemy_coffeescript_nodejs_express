CONNECTION_URL = require('../../config/monogodb.config.coffee').CONNECTION_URL
DATABSE = require('../../config/monogodb.config.coffee').DATABSE
OPTIONS = require('../../config/monogodb.config.coffee').OPTIONS
hash = require './hash.coffee'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
MongoClient = require('mongodb').MongoClient
router = require('express').Router()

passport.serializeUser (email, done) ->
  done null, email

passport.deserializeUser (email, done) ->
  MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
    db = client.db DATABSE
    db.collection('users')
      .findOne({ email })
      .then((user) ->
        return new Promise((resolve, reject) ->
           db.collection('privileges')
            .findOne(role: user.role)
            .then((privilege) ->
              user.permissions = privilege.permissions
              resolve user
            ).catch((error) ->
              reject error
            )
        )
      ).then((user) ->
        done(null, user)
      ).catch((error) ->
        done(error)
      ).then ->
        client.close()

passport.use(
  'local-strategy',
  new LocalStrategy {
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
  }, (req, username, password, done) ->
    MongoClient.connect CONNECTION_URL, OPTIONS, (error, client) ->
      db = client.db DATABSE
      db.collection('users')
        .findOne(
          email: username,
          password: hash.digest password
        ).then((user) ->
          if user
            req.session.regenerate (error) ->
            if error
              done error
            else
              done null, user.email
          else
            done null, false, req.flash('message', 'ユーザー名 または パスワード が間違っています。')
        ).catch((error) ->
          done error
        ).then ->
          client.close()
  )


initialize = ->
  return [
    passport.initialize(),
    passport.session(),
    (req, res, next) ->
      if req.user
        res.locals.user = req.user
      next()
  ]

authenticate = ->
  return passport.authenticate(
    'local-strategy',
    successRedirect: '/account/',
    failureRedirect: '/account/login'
  )

authorize = (privilege) ->
  return (req, res, next) ->
    if req.isAuthenticated() && (req.user.permissions || []).indexOf(privilege) >= 0
      next()
    else
      res.redirect '/account/login'



module.exports =
  initialize: initialize
  authenticate: authenticate
  authorize: authorize