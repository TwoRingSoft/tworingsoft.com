task :init do
  sh 'brew install awscli'
  sh 'rbenv exec bundle'
end

task :build do
	sh 'rbenv exec bundle exec sass --update css'
	sh 'rbenv exec bundle exec jekyll build'
end

task :serve do
	require 'shell'
	shell = Shell.new
	shell.pushd '_site'
	shell.system('python -m SimpleHTTPServer 4000 --bind localhost &')
	puts 'Loading site...'
	sleep 3
	shell.system('open http://localhost:4000')
end

task :endserve do
	sh 'killall Python'
end

task :publish do
  sh 'git push origin'
  sh 'aws s3 sync _site/ s3://tworingsoft.com --exclude .git/ --profile tworing --acl public-read'
end
