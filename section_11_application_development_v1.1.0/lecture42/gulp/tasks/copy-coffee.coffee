config = require '../config.coffee'
gulp = require 'gulp'
del = require 'del'

gulp.task 'copy-javascripts.clean', ->
  return del './javascripts/**/*', cwd: config.path.output

gulp.task 'copy-javascripts', ['copy-javascripts.clean'], ->
  gulp.src('./javascripts/**/*', cwd: config.path.input)
    .pipe gulp.dest './javascripts', cwd: config.path.output