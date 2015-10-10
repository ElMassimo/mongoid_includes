if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'rspec/given'
require 'pry'
require 'mongoid_includes'

# Load Support files
Dir['./spec/support/**/*.rb'].map do |f|
  require f
end

def mongodb_version
  session = Mongoid::Sessions.default
  session.command(buildinfo: 1)[version]
end

I18n.config.enforce_available_locales = false

# These are used when creating any connection in the test suite.
HOST = ENV['MONGOID_SPEC_HOST'] ||= 'localhost'
PORT = ENV['MONGOID_SPEC_PORT'] ||= '27017'
DATABASE = ENV['MONGOID_DATABASE'] ||= 'mongoid_test'

# Set the database that the spec suite connects to.
Mongoid.configure do |config|
  config.load_configuration(
    clients: {
      default: {
        database: DATABASE,
        hosts: [ "#{HOST}:#{PORT.to_i}" ],
        options: {
          max_pool_size: 1,
        }
      }
    },
    sessions: {
      default: {
        database: DATABASE,
        hosts: [ "#{HOST}:#{PORT.to_i}" ]
      }
    }
  )
end

RSpec.configure do |config|
  config.include Mongoid::SpecHelpers
  config.raise_errors_for_deprecations!

  # Drop all collections and clear the identity map before each spec.
  config.before(:each) do
    Mongoid.purge!
  end
end
