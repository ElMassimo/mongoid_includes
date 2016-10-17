require 'mongoid/includes/errors'
require 'mongoid/includes/inclusions'

module Mongoid
  module Includes

    # Internal: Adds and overrides methods in Mongoid::Criteria to enhance eager loading.
    module Criteria

      # Overrides: Get a list of criteria that are to be executed for eager loading.
      def inclusions
        @inclusions ||= Mongoid::Includes::Inclusions.new
      end

      # Public: Eager loads the specified associations.
      #
      # relations   - The relations of the two-level relations to eager load.
      # from:       - The relation through which two-level relations are
      #               loaded from.
      # from_class: - Necessary to solve ambiguity when doing two-level eager
      #               load through a polymorphic relation.
      # loader:       - An optional block that specifies how to load all the
      #               related documents.
      #
      # Notes:
      #   Eager loading brings all the documents into memory, so there is a
      #   sweet spot on the performance gains. Internal benchmarks show that
      #   eager loading becomes slower around 100k documents, but this will
      #   naturally depend on the specific application.
      #
      #   Polymorphic belongs_to relations are supported, but will trigger a
      #   query for each collection of the matched documents types.
      #
      # Example:
      #   Album.includes(:musicians, from: :band)
      #
      # Returns the cloned Mongoid::Criteria.
      def includes(*relations, **options)
        if options[:from]
          from_metadata = add_inclusion(klass, options[:from])
          if from_metadata.polymorphic_belongs_to? && !options[:from_class]
            raise Mongoid::Includes::Errors::InvalidPolymorphicIncludes.new(klass, relations, options)
          end
        end

        owner_class = options[:from_class] || from_metadata.try!(:klass) || self.klass

        relations.flatten.each do |relation|
          add_inclusion(owner_class, relation, options)
        end
        clone
      end

    private

      # Internal: Adds a new inclusion to the criteria.
      #
      # Returns the Mongoid::Includes::Inclusion for the included relation.
      def add_inclusion(owner_class, relation, options = {})
        unless metadata = owner_class.reflect_on_association(relation)
          raise Mongoid::Includes::Errors::InvalidIncludes.new(owner_class, relation, options)
        end
        inclusions.push(metadata, options)
      end
    end
  end
end
