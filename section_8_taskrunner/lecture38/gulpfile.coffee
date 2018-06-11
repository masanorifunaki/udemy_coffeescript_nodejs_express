gulp = require "gulp"
concat = require "gulp-concat"
uglify = require "gulp-uglify"
rename = require "gulp-rename"

gulp.task "minify", ->
  gulp.src ["sample1.js", "sample2.js"], cwd: "./src"
    .pipe concat "bundle.js"
    .pipe uglify()
    .pipe rename suffix: ".min"
    .pipe gulp.dest "./dist"

gulp.task "default", ["minify"]