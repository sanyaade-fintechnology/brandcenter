var gulp = require('gulp');
var shell = require('gulp-shell');
var browserSync = require('browser-sync').create();

// Task for building blog when something changed:
gulp.task('build', shell.task(['bundle exec jekyll build --watch']));
// Or if you don't use bundle:
// gulp.task('build', shell.task(['jekyll build --watch']));

// Task for serving blog with Browsersync
gulp.task('serve', function () {
  browserSync.init({
    browser: "google chrome",
    server: {baseDir: '_site/'}
  });
  // Reloads page when some of the already built files changed:
  gulp.watch('_site/**/*.*').on('change', browserSync.reload);
});

gulp.task("watch", function () {
  gulp.watch([
    "src/**/*.md",
    "src/**/*.html",
    "src/**/*.xml",
    "src/**/*.txt",
    "src/**/*.js"
  ], ["jekyll-rebuild"]);
  // gulp.watch(["serve/assets/stylesheets/*.css"], reload);
  gulp.watch(["src/assets/scss/**/*.scss"], ["styles"]);
});

gulp.task('default', ['build', 'serve']);
