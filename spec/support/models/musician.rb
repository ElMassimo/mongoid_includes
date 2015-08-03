class Person
  include Mongoid::Document

  field :name, type: String
end

class Musician < Person

  has_and_belongs_to_many :bands

  def musician?
    true
  end
end
