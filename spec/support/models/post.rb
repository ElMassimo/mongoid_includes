require_relative './person'

class Post
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title, type: String
  field :content, type: String
  field :rating, type: Integer
  field :person_title, type: String, default: ->{ person.title if ivar(:person) }

  belongs_to :person, counter_cache: true
end
