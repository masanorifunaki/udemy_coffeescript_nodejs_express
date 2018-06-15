config = require '../config.coffee'
gulp = require 'gulp'
del = require 'del'

gulp.task 'clean-log', ->
  return del './**/*', cwd: config.path.log