gulp = require "gulp"
concat = require "gulp-concat"
sass = require "gulp-sass"
rename = require "gulp-rename"

gulp.task "sass", ->
  gulp.src ["sample1.scss", "sample2.scss"], cwd: "./src"
    .pipe concat "bundle.scss"
    .pipe sass outputStyle: "compressed"
    .pipe rename suffix: ".min"
    .pipe gulp.dest "./dist"

gulp.task "default", ["sass"]