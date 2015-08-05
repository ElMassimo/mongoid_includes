class Album
  include Mongoid::Document

  field :name, type: String
  field :release, type: Date

  belongs_to :owner, polymorphic: true
  has_many :songs
end
