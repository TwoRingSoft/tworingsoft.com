init:
	brew bundle
	rbenv install --skip-existing
	rbenv exec gem install bundler
	rbenv exec bundle update

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
	./scripts/publish
