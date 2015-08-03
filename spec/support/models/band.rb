require './spec/support/models/model'

class Artist
  include Mongoid::Document

  field :name, type: String

  has_many :albums
end

class Band < Artist

  has_and_belongs_to_many :musicians
end
