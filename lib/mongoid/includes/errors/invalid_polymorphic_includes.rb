module Mongoid
  module Includes
    module Errors

      # Public: This error is raised when an invalid nested inclusion is
      # attempted through a polymorphic relation.
      class InvalidPolymorphicIncludes < InvalidIncludes

        # Internal: Key of the translation message
        def type
          :invalid_polymorphic_nested_includes
        end
      end
    end
  end
end
