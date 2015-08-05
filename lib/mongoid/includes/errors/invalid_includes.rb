module Mongoid
  module Includes
    module Errors

      # Public: This error is raised when an invalid include is performed.
      class InvalidIncludes < Mongoid::Errors::MongoidError

        # Public: Composes a message from the class the includes would be
        # performed on, the relations to be included, and the options.
        def initialize(klass, args, options)
          super compose_message(type, options.merge(
            klass: klass, relations: klass.relations.keys, args: Array.wrap(args)
          ))
        end

        # Internal: Key of the translation message
        def type
          :invalid_includes
        end

        # Overrides: Helps to keep the templates simple by using inspect on the options.
        def compose_message(type, options)
          super type, options.transform_values { |value|
            value.is_a?(Array) ? value.map(&:inspect).join(', ') : value.inspect
          }
        end
      end
    end
  end
end
