# TwoRingSoft.github.io
website for tworingsoft.com

All development happens on the `develop` branch, and the final compiled site is pushed to remote `master` using `git subtree`.

**Note**: `git subtree push` has no `--force` option, so commits already pushed cannot be amended!

### Jekyll

The blog is built from markdown documents for individual posts into HTML using Jekyll. Then, posts are composed into `index.html`. 

The entire site is run through Jekyll for simplicity. From the root directory:

	jekyll build --watch

This generates a `_site/` directory. Push the contents of this directory to the remote `master` branch:

	git subtree push --prefix _site origin master

The `_site/` directory is also always checked into source control with the corresponding development changes onto the `develop` branch.

### SASS

Uses SASS for style sheets. From the root directory:

	sass --watch css/
