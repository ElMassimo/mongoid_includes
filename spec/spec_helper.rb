require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec/given'
require 'pry'
require 'mongoid_includes'

# Load Support files
Dir[File.join(File.dirname(__FILE__), 'spec/support/**/*.rb')].each { |f| require f }

