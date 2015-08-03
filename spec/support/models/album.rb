require './spec/support/models/model'

class Album
  include Mongoid::Document

  field :name, type: String

  belongs_to :artist
  has_many :songs
end
