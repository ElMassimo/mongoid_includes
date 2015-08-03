class Song
  include Mongoid::Document

  field :name, type: String

  belongs_to :album
end
