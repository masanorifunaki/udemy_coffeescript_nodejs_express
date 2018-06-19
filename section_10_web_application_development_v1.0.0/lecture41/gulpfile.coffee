gulp = require 'gulp'
del = require 'del'

gulp.task 'delete-log', ->
  return del './log/*'

gulp.task 'default', ['delete-log']