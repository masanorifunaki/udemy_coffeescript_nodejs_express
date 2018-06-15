config = require './gulp/config.coffee'
gulp = require 'gulp'
load = require 'require-dir'
register = 'coffee-script/register'

load './gulp/tasks', recurse: true

development = [
  'copy-third_party',
  'copy-images',
  'copy-coffee',
  'compile-sass'
]

production = [
  'copy-third_party',
  'copy-images',
  'copy-coffee',
  'compile-sass'
]

gulp.task('default', if config.env.IS_DEVELOPMENT then development else production)