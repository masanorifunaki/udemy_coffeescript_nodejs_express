gulp = require "gulp"
del = require "del"
rename = require "gulp-rename"
concat = require "gulp-concat"

gulp.task "copy", ->
  gulp.src "./src/sample1.txt"
    .pipe gulp.dest "./dist"

gulp.task "delete", ->
  return del "./dist/*"

gulp.task "rename", ->
  gulp.src "./src/sample1.txt"
    .pipe rename "hoge.txt"
    .pipe gulp.dest "./dist"

gulp.task "concat", ->
  gulp.src ["sample1.txt", "sample2.txt"], cwd: "./src"
    .pipe concat "bundle.js"
    .pipe gulp.dest "./dist"

gulp.task "default", ["copy"]