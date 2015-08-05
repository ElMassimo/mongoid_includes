class Artist
  include Mongoid::Document

  field :name, type: String

  has_many :albums
  has_one :musician
end
