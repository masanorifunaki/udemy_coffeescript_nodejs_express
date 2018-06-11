gulp = require "gulp"

gulp.task "a", ->
  console.log "a"

gulp.task "b", ["a"], ->
  console.log "b"

gulp.task "default", ["b"]