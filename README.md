# SumUp Brand Guide

This page serves as a central place to collect everything that concerns the SumUp brand as such. The page is built using Jekyll and Github pages.

## Setup locally

Install gems: `bundle install` (if you don't have bundler installed: `gem install bundler`)
Install node modules: `npm install`

## Running

### Using gulp for live reloading

`gulp`

### Without gulp (no node.js)

`jekyll serve`

## Deploying

When you're ready to deploy your changes just run `gulp deploy` from the command line. The gulp task will compile your site again, and add the contents of the `prod` directory to the branch `gh-pages` which Github uses to host the site.
