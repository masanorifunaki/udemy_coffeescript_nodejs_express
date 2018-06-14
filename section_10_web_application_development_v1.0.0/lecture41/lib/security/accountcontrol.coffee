CONNECTION_URL = require("../../config/mongodb.config.coffee").CONNECTION_URL
DATABASE = require("../../config/mongodb.config.coffee").DATABASE
passport = require "passport"
LocalStrategy = require("passport-local").Strategy
MongoClient = require("mongodb").MongoClient


passport.serializeUser (email, done) ->
  done null, email

passport.deserializeUser (email, done) ->
  MongoClient.connect(CONNECTION_URL).then((client) ->
      client.db(DATABASE).collection("users")
      .findOne({
        email: { $eq: email }
      })
  ).then((user) ->
    done(null, {
      email: user.email,
      name: user.name,
      role: user.role
    })
  ).catch (err) ->
    done err

passport.use(
  "local-login",
  new LocalStrategy {
    usernameField: "username",
    passwordField: "password",
    passReqToCallback: true
  }, (req, username, password, done) ->
    MongoClient.connect(CONNECTION_URL).then((client) ->
      client.db(DATABASE).collection("users").findOne({
          email: { $eq: username },
          password: { $eq: password }
        })
    ).then((user) ->
      done null, user.email
    ).catch (err) ->
      done null, false, req.flash("message", "ユーザー名 または パスワード が違います。")
)

initialize = ->
  return [
    passport.initialize(),
    passport.session(),
    (req, res, next) ->
      if req.isAuthenticated()
        res.locals.user = req.user
      next()
  ]

authenticate = ->
  return passport.authenticate(
    "local-login", {
      successRedirect: "/account",
      failureRedirect: "/account/login"
    }
  )

authorize = (role) ->
  return (req, res, next) ->
    if req.isAuthenticated() && req.user.role == role
      next()
    else
      res.redirect "/account/login"

module.exports = {
  initialize,
  authenticate,
  authorize
}
