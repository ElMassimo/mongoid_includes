module Mongoid
  module Includes
    module Errors

      # This error is raised when an invalid nested inclusion is performed through
      # a polymorphic relation.
      class InvalidPolymorphicIncludes < InvalidIncludes

        def initialize(klass, relations, options)
          super(klass, relations, options)
        end

        def type
          :invalid_polymorphic_nested_include
        end
      end
    end
  end
end
