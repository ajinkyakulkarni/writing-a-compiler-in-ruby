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
  system("cucumber features")
end

desc "create rdoc in /doc"
rd = Rake::RDocTask.new("doc") do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "*.rb")
  rd.options << "--all"
  rd.rdoc_dir = "doc"
end
