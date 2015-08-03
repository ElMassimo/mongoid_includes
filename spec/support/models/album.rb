class Album
  include Mongoid::Document

  field :name, type: String

  belongs_to :owner, polymorphic: true
  has_many :songs
end
