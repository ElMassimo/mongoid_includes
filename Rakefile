require 'bundler'
Bundler.setup

require 'rake'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'mongoid/includes/version'

task :gem => :build
task :build do
  system 'gem build mongoid_includes.gemspec'
end

task :install => :build do
  system "sudo gem install mongoid_includes-#{Mongoid::Includes::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Mongoid::Includes::VERSION} -m 'Tagging #{Mongoid::Includes::VERSION}'"
  system 'git push --tags'
  system "gem push mongoid_includes-#{Mongoid::Includes::VERSION}.gem"
  system "rm mongoid_includes-#{Mongoid::Includes::VERSION}.gem"
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--format progress']
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec
