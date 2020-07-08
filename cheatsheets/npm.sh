#!/bin/bash

# Load node virtual machine for this session
nvm use stable

# Setup packages.json
npm init

# Install --dev packages with npm (bower, gulp, gulp plugins)
npm install bower gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-jshint gulp-concat gulp-uglify gulp-imagemin gulp-notify gulp-rename gulp-livereload gulp-cache del gulp-inject --save-dev

# Install vendor packages with bower (jquery, bootstrap, modernizr).
bower init
bower install modernizr --save
bower install susy --save-dev

# Define sources in .gulpfile (.js, .css, fonts, etc).
config.app config.dist

# create html and include js and css with grunt-usemin or gulp-inject.
mkdir -p src/scss
mkdir -p dist/css
mkdir src/js src/images src/fonts dist/fonts dist/js dist/images
touch src/index.html

