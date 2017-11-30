---
title: Image Galleries with Jekyll
date: 2017-11-05
layout: post
abstract: Describing my journey to build a photo gallery for my website using Jekyll/Liquid to template all the things.
---

Recently I decided that I want a photo gallery on my website, a static HTML site generated by Jekyll, just like this one. I wanted a page that lists all the albums, an index for each album that shows a gallery of all the photos, which lead to slideshow of larger images that then lead to the full raw images themselves. It turned into a fun exercise of writing Jekyll front matter and templates inside Ruby strings in a Rake task, trying to keep variables straight where data flows from one process to the next.

# Inputs and outputs

I wanted the "input" to be as simple as possible: a directory of the images I wanted to add as an album. I decided at the beginning that I'd like all metadata about each image, such as time, location and descriptions, to reside in the image file itself as EXIF data, to ensure maximum portability and consistency. The directory name would be a slugified version of the album's name and date as an album ID:

```
photos/
	2017-10-15-my-album-name/
		image_1.jpg
		image_2.jpg
		...
	2017-11-1-another-album-name/
		image_1.jpg
		image_2.jpg
		...
```

I began designing a Rake task to extract the descriptions and other EXIF data from the images and create HTML files containing the necessary YAML front matter to access in Liquid templates. Originally I thought the preprocessing should generate a directory structure like this:

```
_photos/
	index.html
	2017-10-15-my-album-name/
		index.html
		img/
			image_1.html
			image_1.jpg
			image_2.html
			image_2.jpg
			...
	2017-11-1-another-album-name/
		index.html
		img/
			image_1.html
			image_1.jpg
			image_2.html
			image_2.jpg
			...
```

where each album's `index.html` and `image_N.html` would contain YAML front matter for the album and individual images, respectively. Then I'd have a single collection specified in my `_config.yml`:

```
collections:
  - photos
```

and have Jekyll treat each subdirectory as a collection item, containing another sort of collection in each `img/` directory. I hoped it could somehow work automatically, instead of having to dynamically insert each album ID in the `_config.yml`:

```
collections:
  - photos
  - 2017-10-15-my-album-name
  - 2017-11-1-another-album-name
  - ...
```

which would certainly be an abuse of `_config.yml`. 

# Filtered flat files

Unfortunately, this is not the way Jekyll collections are designed to work. They must all be in the same directory (the root directory by default, but recently [support for a common subdirectory](https://github.com/jekyll/jekyll/pull/6331) was added; unfortunately this model remains too simple to implement more complicated logic and structures, as mentioned in [this issue](https://github.com/jekyll/jekyll/issues/6030), for example). So, no subcollections, or whatever I was trying to do with `my_album_1` and `my_album_2`.

The final design has two collections:

```
collections:
  - photos
  - albums
```

I still use as "input" to the Rake task a directory containing images, under the main `photos` directory (different from the `_photos` directory!):

```
photos/
	2017-10-15-my-album-name/
		image_1.jpg
		image_2.jpg
		...
```

This directory path is the sole argument to the Rake task, which carries out the following steps:

- ask user to input the album name, description, and cover image filename
- move all the images to a `img/` subdirectory
- generate album YAML in `_albums/2017-10-15-my-album-name.html`
- generate YAML for each image in `_photos/2017-10-15-my-album-name-N.html`, using data pulled from each image using [exiftool](https://www.sno.phy.queensu.ca/~phil/exiftool/) (where N is the sequential order of the photos by time and date, sorted in the Rake task)
- generate a thumbnail for each image using [imagemagick](https://www.imagemagick.org/script/index.php)

The steps are designed to be as idempotent as possible, so it will e.g. read the album name, description and cover image filename from a preexisting album HTML's YAML, or skip thumbnail generation if they already exist. After running the Rake task for the example input above, we should have the following files:

```
_photos/
	2017-10-15-my-album-name-1.html
	2017-10-15-my-album-name-2.html
_albums/
	2017-10-15-my-album-name.html
photos/
	2017-10-15-my-album-name/
		slideshow/
			index.html
		img/
			image_1.jpg
			image_1-thumbnail.jpg
			image_2.jpg
			image_2-thumbnail.jpg
```

When the Jekyll build is run, each photo gallery index template will filter through *all* albums' photos, picking out only the ones that specify the same album ID. Jekyll collections operate very similarly to MapReduce, where you have huge flat lists of items that you can filter, group and map by relations at runtime. The resulting output in `_site/` looks like this:

```
_site/
	photos/
		index.html (album list)
		2017-10-15-my-album-name/
			index.html (this album's thumbnail gallery)
			slideshow/
				index.html (first big image in slideshow)
				2/
					index.html (next big image in slideshow)
			img/
				image_1.jpg
				image_1-thumbnail.jpg
				image_2.jpg
				image_2-thumbnail.jpg
```

One thing I haven't quite figured out is how to force `octopress-paginate` to put the first slide under a subdirectory named `1/`, so I could have consistent navigation semantics for navigating back from the slideshow. I have an `_include` that constructs a "Back" button for any page, so I simply parameterized it to remain as-is (`<a href="..">...`) for the first slide, since that would pop back to the thumbnail gallery, and override it to point at `"../.."` for all the subdirectory slides.

# Grafting the gallery

Originally I built a vertical list, with thumbnails on the left and descriptions on the right, extending all the way across the page (this is the layout used for the album list). This left too much negative space on the right, so I decided to go with a more grid-like layout, flowing from left to right and wrapping to the window width. Each cell would have an image with its description underneath, where the description wraps to the width of the image–this turns out to be tricky using HTML/CSS. You need to specify a width for the table for `word-wrap: break-word;` to work in the cell containing the description. So, I had to read the image width using `exiftool`, write it to the photo's YAML front matter, then retrieve that value in the liquid tags that render the gallery HTML. In the end it's an interesting mix of interpolating Ruby variables into shell invocations, Liquid templates and YAML front matter, and programming the use of front matter variables from Liquid templates within Ruby strings.


# Slideshow and tell

Originally each image thumbnail linked directly to the full-size raw image. I wanted it instead to enter a slideshow to page back and forth through larger images, again with their descriptions. Each image here would then be clickable to get the raw version, to zoom using the browser's built in tools or save. I added a new step in the Rake task to create `photos/$albumName/slideshow/index.html`, and inject YAML front matter utilizing [octopress-paginate](https://github.com/octopress/paginate) to generate a slideshow page for each image. To do so, I simply set the `per_page` value to `1` and the collection to paginate as `photos`. 

This worked great for the first photo gallery I tested with, but once I added the second, a problem surfaced: each album's slideshow was paginating through *all* of the photos in `_photos`, irrespective of album. The final touch was to write a `category` parameter into the front matter of each HTML file in `_photos` that matches the album ID, and then paginate on both the `photos` collection and the `category` matching the target album for the slideshow. (Another nit with `octopress-paginate` is that specifying both `collection` and `category` outputs scary deprecation notices-which seems to grow w.r.t. the product of the amount of collections and categories-but does not break the build: [GitHub issue](https://github.com/octopress/paginate/issues/35). Beware that `octopress-paginate` does not appear to be actively maintained–the last commit was over 13 months ago now, and that GitHub issue is about the same age.) 

[Voilà](http://armcknight.com/photos), et la [sauce](https://github.com/armcknight/armcknight.com/blob/69537f14614e32ccfe3996d0e6a5d4027c016678/Rakefile)!
