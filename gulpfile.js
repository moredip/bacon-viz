var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    concat = require('gulp-concat'),
    sourcemaps = require('gulp-sourcemaps');

gulp.task('coffee-lib', function () {
    gulp.src('./lib/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee())
    .pipe(sourcemaps.write())
    .pipe(concat('bacon-vis.js'))
    .pipe(gulp.dest('js'));
});

gulp.task('coffee', function () {
  gulp.src('./*.coffee')
  .pipe(sourcemaps.init())
  .pipe(coffee())
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('js'));
});

gulp.task('default', ['coffee-lib','coffee']);

gulp.task('watch', function(){
  gulp.watch('./lib/*.coffee', ['coffee-lib']);
  gulp.watch('./*.coffee', ['coffee']);
});
