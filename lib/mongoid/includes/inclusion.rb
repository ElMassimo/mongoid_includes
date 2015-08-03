module Mongoid
  module Includes

    # Public: Represents a relation that needs to be eager loaded.
    class Inclusion < SimpleDelegator

      alias_method :metadata, :__getobj__
      attr_reader :from

      def initialize(metadata, from: nil, loader: nil)
        super(metadata)
        @from, @loader = from, loader
      end

      # Public: Returns true if the relation is not direct.
      def nested?
        !!from
      end

      # Public: Preloads the documents for the relation. Users a custom block
      # if one was provided, or fetches them using the class and the foreign key.
      def load_documents_for(foreign_key, foreign_key_values)
        if @loader
          @loader.call(foreign_key_values)
        else
          klass.any_in(foreign_key => foreign_key_values)
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
