tworingsoft.com is served via AWS S3.

# Dependencies

## Jekyll

The blog is built from markdown documents for individual posts into HTML using Jekyll. Then, posts are composed into `index.html`. 

The entire site is run through Jekyll for simplicity, and the generated `_site` directory is pushed to the appropriate branch for GitHub pages to render.

## SASS

Uses SASS for style sheets. 
	
# Building

To build the entire site, including SASS stylesheets, run

	rake build

To preview the site on a local machine (after building), 

	rake serve

don't forget to 

	rake endserve

when you're done!

## Organization

### Styles

Topical styles are in `.scss` files prefixed with two underscores (‘__’), e.g. `__text.scss`. Top-level files like `_common.scss` and `_subpage.scss` have a single underscore prefix, and are used to be reusable includes for individual pages' styles. 

E.g. `blog-post.scss` imports `_subpage.scss` which imports `_common.scss` which imports both `__text.scss` and `__tables.scss`.

# Publishing

Sync the `_site/` directory to the tworingsoft.com bucket on AWS. Excludes .git/

	rake publish 
