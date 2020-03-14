init:
	brew bundle
	rbenv install --skip-existing
	rbenv exec gem install bundler
	rbenv exec bundle

build:
	sass --update css
	rbenv exec bundle exec jekyll build

serve:
	cd _site && python -m http.server 4000 --bind localhost &
	echo "Loading site..."
	sleep 3
	open http://localhost:4000

endserve:
	killall Python

publish:
ifdef subdir
	aws s3 sync "_site/$(subdir)" "s3://tworingsoft.com/$(subdir)" --exclude .git/ --profile tworing --acl public-read"
else
	aws s3 sync "_site/" "s3://tworingsoft.com/" --exclude .git/ --profile tworing --acl public-read"	
endif
