module Mongoid
  module Includes

    # Public: Adds support for polymorphic and nested eager loading.
    module EagerLoad

      # Override: Partitions the inclusions into the different types.
      def eager_load(docs)
        if eager_loadable?
          nested_inclusions, inclusions = criteria.inclusions.partition(&:nested?)
          polymorphic_inclusions, inclusions = inclusions.partition(&:polymorphic_belongs_to?)
          full_preload(docs, inclusions, polymorphic_inclusions, nested_inclusions)
        end

        docs
      end

      # Internal: Performs the normal inclusions first, which allows to perform
      # the polymorphic eager loading. Nested inclusions are performed at the end.
      def full_preload(docs, inclusions, polymorphic_inclusions, nested_inclusions)
        preload(inclusions, docs)

        polymorphic_inclusions.each do |metadata|
          preload_polymorphic(metadata, docs)
        end

        preload_nested(nested_inclusions, docs)
      end

      # Internal: Preloads each polymorphic includes, by grouping the documents by
      # concrete type of the polymorphic relation, and making a query for each type.
      def preload_polymorphic(inclusion, docs)
        docs.group_by do |doc|
          doc.send(inclusion.inverse_type) # The {name}_type attribute in polymorphic relations.
        end.select { |type, _| type }.each do |type, docs|
          concrete_inclusion = inclusion.for_class_name(type)
          preload([concrete_inclusion], docs)
        end
      end

      # Internal: The documents are grouped by the nested property, and all the
      # includes by that property are processed as usual.
      def preload_nested(nested_inclusions, docs)
        nested_inclusions.group_by(&:from).each do |from, inclusions|
          preload(inclusions, docs.flat_map(&from).compact)
        end
      end
    end
  end
end
