# TwoRingSoft.github.io
website for tworingsoft.com

All development happens on the `develop` branch, and the final compiled site is pushed to remote `master`.

### Stylesheets

Uses SASS for style sheets. From the root directory:
	
	sass --watch css/
	
### Jekyll
	
The blog is built from markdown documents for individual posts into HTML using Jekyll. Then, posts are composed into `index.html`. 

The entire site is run through Jekyll for simplicity. From the root directory:

	jekyll build --watch
	
This generates a `_site/` directory. Push the contents of this directory to the remote `master` branch:

	
	
The `_site/` directory is also always checked into source control with the corresponding development changes onto the `develop` branch.
