require 'mongoid/includes/inclusion'

module Mongoid
  module Includes

    # Public: Collection of relations that need to be eager loaded.
    class Inclusions < SimpleDelegator

      # Internal: By default, it wraps an empty set.
      def initialize(object = [])
        super Set.new(object)
      end

      # Public: Adds a new relation as an inclusion.
      #
      # Returns the added inclusion.
      def push(metadata, options = {})
        metadata = Inclusion.new(metadata, options) unless metadata.is_a?(Inclusion)

        # Ensure that an inclusion with a specified loader or modifier replaces
        # a previously specified loader.
        delete(metadata) if metadata.loader || metadata.modifier

        # Internally it's a set so it won't add it twice.
        add(metadata)

        metadata
      end

      # Public: Returns the sum of the inclusions without any duplicates.
      def +(inclusions)
        Inclusions.new(union(inclusions))
      end

      # Public: Returns a new Inclusions without any duplicates.
      def uniq
        dup
      end
    end
  end
end
