task :build do
	sh 'sass --update css'
	sh 'jekyll build'
end

task :publish do
	sh 'git subtree push --prefix _site origin master'
end
