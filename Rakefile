require 'rubygems'
require "rake"
require "rake/rdoctask"
require 'rspec/core/rake_task'

task :default => [ :test ]
task :test    => [ :specs, :features ]


desc "run rspec tests in test/"
RSpec::Core::RakeTask.new(:specs) do |t|
  t.spec_files = FileList['test/*.rb']
  t.verbose = true
end

desc "run cucumber features in features/"
task :features do |t|
  system("cd features && cucumber -r . -e compiler.feature .")
end

task :failing do |t|
  system("cd features && cucumber -r . -e compiler.feature . --format rerun --out rerun.txt")
  system("cd features && cucumber -r . @rerun.txt")
end

desc "create rdoc in /doc"
rd = Rake::RDocTask.new("doc") do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "*.rb")
  rd.options << "--all"
  rd.rdoc_dir = "doc"
end
