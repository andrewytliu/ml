# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ml"
  gem.homepage = "http://github.com/eggegg/ml"
  gem.license = "MIT"
  gem.summary = %Q{Machine learning library for Ruby}
  gem.description = %Q{Machine learning library in Ruby}
  gem.email = "andrewliu33@gmail.com"
  gem.authors = ["Andrew Liu"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |spec|
  spec.libs << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
  spec.rcov_opts << '--exclude "gems/*"'
end

task :default => :spec

#require 'yard'
#YARD::Rake::YardocTask.new
