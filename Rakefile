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

desc 'Push the git repo to remote and sync the compiled site to S3, with an optional subdirectory to only publish portions.'
task :publish, [:subdir] do |t, args|
  sh 'git push origin'
  subdir = args[:subdir]
  local = '_site/'
  remote = 's3://tworingsoft.com/'
  if subdir != nil then
    local << subdir
    remote << subdir
  end
  sh "aws s3 sync #{local} #{remote} --exclude .git/ --profile tworing --acl public-read"
end
