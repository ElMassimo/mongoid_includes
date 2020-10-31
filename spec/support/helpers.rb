module Mongoid
  class QueryCounter
    attr_reader :events

    def initialize
      @events = []
    end

    def instrument
      subscriber = ActiveSupport::Notifications.subscribe('query.moped') do |*args|
        @events << ActiveSupport::Notifications::Event.new(*args)
      end
      yield
    ensure
      ActiveSupport::Notifications.unsubscribe(subscriber)
    end

    def inspect
      @events.map { |e| e.payload[:ops].map(&:log_inspect) }.join("\n")
    end
  end
end

module Mongoid
  module SpecHelpers
    def connection_class
      Mongo::Server::ConnectionBase
    end

    def expect_query(number)
      rv = nil
      RSpec::Mocks.with_temporary_scope do
        if number > 0
          expect_any_instance_of(connection_class).to receive(:command_started).exactly(number).times.and_call_original
        else
          expect_any_instance_of(connection_class).not_to receive(:command_started)
        end
        rv = yield
      end
      rv
    end

    def expect_no_queries(&block)
      expect_query(0, &block)
    end
  end
end
