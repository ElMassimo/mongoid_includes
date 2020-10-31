class Address
  include Mongoid::Document

  field :_id, type: String, overwrite: true, default: ->{ street.try(:parameterize) }

  attr_accessor :mode

  field :address_type
  field :number, type: Integer
  field :no, type: Integer
  field :h, as: :house, type: Integer
  field :street
  field :city
  field :state
  field :post_code
  field :parent_title
  field :services, type: Array
  field :aliases, as: :a, type: Array
  field :test, type: Array
  field :latlng, type: Array
  field :map, type: Hash
  field :move_in, type: DateTime
  field :end_date, type: Date
  field :s, type: String, as: :suite
  field :name, localize: true

  belongs_to :band

  embedded_in :addressable, polymorphic: true

  validates_presence_of :street, on: :update
  validates_format_of :street, with: /\D/, allow_nil: true
end
