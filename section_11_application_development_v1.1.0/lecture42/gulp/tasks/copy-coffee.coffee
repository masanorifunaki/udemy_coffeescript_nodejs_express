config = require "../config.coffee"
gulp = require "gulp"
del = require "del"

gulp.task "copy-coffee.clean", ->
  return del "./coffee/**/*", cwd: config.path.output

gulp.task "copy-coffee", ["copy-coffee.clean"], ->
  gulp.src("./coffee/**/*", { cwd: config.path.input })
    .pipe gulp.dest "./coffee", cwd: config.path.output