require './spec/support/models/person'

class Musician < Person

  has_and_belongs_to_many :bands
end
