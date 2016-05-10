var gulp = require('gulp');
var shell = require('gulp-shell');
var del = require("del");
var browserSync = require('browser-sync').create();

// Deletes the directory that is used to serve the site during development
gulp.task("clean:dev", del.bind(null, ["dev"]));

// Runs the build command for Jekyll to compile the site locally
// This will build the site with the production settings
gulp.task("jekyll:dev", shell.task("bundle exec jekyll build"));

gulp.task("jekyll-rebuild", ["jekyll:dev"], function () {
  browserSync.reload();
});
