# TwoRingSoft.github.io
website for tworingsoft.com

Uses SASS for style sheets. From the root directory:
	
	sass --watch css/
	
The blog is built from markdown documents for individual posts into HTML using Jekyll. Then, posts are composed into index.html. From the root directory:

	jekyll build --watch --source blog/posts/markdown --destination blog/posts/html