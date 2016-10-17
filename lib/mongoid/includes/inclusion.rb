module Mongoid
  module Includes

    # Public: Represents a relation that needs to be eager loaded.
    class Inclusion < SimpleDelegator

      # Public: Convenience getter for the wrapped metadata.
      alias_method :metadata, :__getobj__

      def initialize(metadata, options = {})
        super(metadata)
        @options = options
      end

      # Public: Returns true if the relation is not direct.
      def nested?
        !!from
      end

      # Public: Checks if the collection already has an inclusion with the
      # specified metadata.
      def eql?(other)
        metadata == other && (!other.respond_to?(:from) || from == other.from)
      end

      # Public: Returns true if the relation is a polymorphic belongs_to.
      def polymorphic_belongs_to?
        metadata.polymorphic? && metadata.relation == Mongoid::Relations::Referenced::In
      end

      # Public: Name of the relation from which a nested inclusion is performed.
      def from
        @from ||= @options[:from]
      end

      # Internal: Proc that will return the included documents from a set of foreign keys.
      def loader
        @loader ||= @options[:loader]
      end

      # Internal: Proc that will modify the documents to include in the relation.
      def modifier
        @modifier ||= @options[:with]
      end

      # Public: Preloads the documents for the relation. Users a custom block
      # if one was provided, or fetches them using the class and the foreign key.
      def load_documents_for(foreign_key, foreign_key_values)
        if loader
          loader.call(foreign_key, foreign_key_values)
        else
          docs = klass.any_in(foreign_key => foreign_key_values)
          modifier ? modifier.call(docs) : docs
        end
      end

      # Public: Clones the inclusion and changes the Mongoid::Metadata::Relation
      # that it wraps to make it non polymorphic and target a particular class.
      #
      # Returns an Inclusion that can be eager loaded as usual.
      def for_class_name(class_name)
        Inclusion.new metadata.clone.instance_eval { |relation_metadata|
          self[:class_name] = @class_name = class_name
          self[:polymorphic], self[:as], @polymorphic, @klass = nil
          self
        }
      end
    end
  end
end
