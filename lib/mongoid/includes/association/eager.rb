module Mongoid
  module Includes
    module Association

      # Internal: Patch to the base class for eager load preload functions,
      # that interacts with the Mongoid::Includes::Inclusion as @medatada.
      module Eager

        # Internal: Performs eager load and iterates over the preloaded documents
        # for the current relation.
        def each_loaded_document
          foreign_key_values = keys_from_docs

          return @association.klass.none if foreign_key_values.empty?

          @association.load_documents_for(key, foreign_key_values).each do |doc|
            yield doc
          end
        end
      end
    end
  end
end
