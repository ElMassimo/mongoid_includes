# encoding: utf-8
module Mongoid
  module Includes
    module Errors

      # This error is raised when an invalid include is performed.
      class InvalidIncludes < Mongoid::Errors::MongoidError

        def initialize(klass, relations, options)
          options = {
            klass: klass.name,
            args: Array.wrap(relations).map(&:inspect).join(', '),
            relations: klass.relations.keys.map(&:inspect).join(", ")
          }
          super compose_message(type, options)
        end

        def type
          :invalid_includes
        end
      end
    end
  end
end
