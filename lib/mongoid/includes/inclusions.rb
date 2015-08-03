require 'mongoid/includes/inclusion'

module Mongoid
  module Includes

    # Public: Collection of relations that need to be eager loaded.
    class Inclusions < SimpleDelegator

      # Internal: By default, it wraps an empty array.
      def initialize(object = [])
        super
      end

      # Public: Adds a new relation as an inclusion.
      def push(metadata, options = {})
        metadata = Inclusion.new(metadata, options) unless metadata.is_a?(Inclusion)
        super(metadata)
      end

      # Public: Checks if the collection already has an inclusion with the
      # specified metadata.
      def include?(metadata)
        any? { |inclusion| inclusion.metadata == metadata }
      end
    end
  end
end
