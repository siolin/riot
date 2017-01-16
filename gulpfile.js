const gulp        = require('gulp');
const browserSync = require('browser-sync').create();
const sass        = require('gulp-sass');
const concat      = require('gulp-concat');
const del         = require('del');

// Static Server + watching scss/html files
gulp.task('serve', ['sass', 'tags'], function() {

  browserSync.init({
    server: "./"
  });

  gulp.watch("./tags/**/*.tag", ['tags'])
  gulp.watch("./styles/sass/**/*.scss", ['sass']);
  gulp.watch("./*.html").on('change', browserSync.reload);
});

// Compile sass into CSS & auto-inject into browsers
gulp.task('sass', function() {
  return gulp.src("styles/sass/*.scss")
    .pipe(sass())
    .pipe(gulp.dest("./styles"))
    .pipe(browserSync.stream());
});

gulp.task('tags', function() {
  // del('./tags/all.tag');
  return gulp.src("tags/**/*.tag")
    .pipe(concat('all.tag'))
    .pipe(gulp.dest("./"))
    .pipe(browserSync.stream());
});

gulp.task('default', ['serve']);
