module Mongoid
  module Includes
    module Errors

      # Public: This error is raised when an invalid include is performed.
      class InvalidIncludes < Mongoid::Errors::MongoidError

        # Public: Composes a message from the class the includes would be
        # performed on, the relations to be included, and the options.
        def initialize(klass, relations, options)
          super compose_message(type, options.transform_values(&:inspect).merge(
            klass: klass.name,
            args: Array.wrap(relations).map(&:inspect).join(', '),
            relations: klass.relations.keys.map(&:inspect).join(", ")
          ))
        end

        # Internal: Key of the translation message
        def type
          :invalid_includes
        end
      end
    end
  end
end
