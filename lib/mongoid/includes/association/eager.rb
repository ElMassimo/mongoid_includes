module Mongoid
  module Includes
    module Association

      # Internal: Patch to the base class for eager load preload functions,
      # that interacts with the Mongoid::Includes::Inclusion as @medatada.
      module Eager

        # Internal: Performs eager load and iterates over the preloaded documents
        # for the current relation.
        def each_loaded_document
          @association.load_documents_for(key, keys_from_docs).each do |doc|
            yield doc
          end
        end
      end
    end
  end
end
