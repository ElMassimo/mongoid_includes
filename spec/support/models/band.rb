class Artist
  include Mongoid::Document

  field :name, type: String

  has_many :albums
  has_one :musician
end

class Band
  include Mongoid::Document

  field :name, type: String

  has_many :albums
  has_and_belongs_to_many :musicians
end
