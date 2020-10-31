class Person
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  attr_accessor :mode

  class_attribute :somebody_elses_important_class_options
  self.somebody_elses_important_class_options = { keep_me_around: true }

  field :username, default: -> { "arthurnn#{rand(0..10)}" }
  field :title
  field :terms, type: Mongoid::Boolean
  field :pets, type: Mongoid::Boolean, default: false
  field :age, type: Integer, default: "100"
  field :dob, type: Date
  field :employer_id
  field :lunch_time, type: Time
  field :aliases, type: Array
  field :map, type: Hash
  field :map_with_default, type: Hash, default: {}
  field :score, type: Integer
  field :blood_alcohol_content, type: Float, default: ->{ 0.0 }
  field :last_drink_taken_at, type: Date, default: ->{ 1.day.ago.in_time_zone("Alaska") }
  field :ssn
  field :owner_id, type: Integer
  field :security_code
  field :reading, type: Object
  field :bson_id, type: BSON::ObjectId
  field :pattern, type: Regexp
  field :override_me, type: Integer
  field :at, as: :aliased_timestamp, type: Time
  field :t, as: :test, type: String
  field :i, as: :inte, type: Integer
  field :a, as: :array, type: Array
  field :desc, localize: true
  field :test_array, type: Array
  field :overridden_setter, type: String
  field :arrays, type: Array
  field :range, type: Range

  index age: 1
  index addresses: 1
  index dob: 1
  index name: 1
  index title: 1

  index({ ssn: 1 }, { unique: true })

  attr_reader :rescored

  embeds_many :addresses, as: :addressable, validate: false do
    def extension
      "Testing"
    end
    def find_by_street(street)
      where(street: street).first
    end
  end

  has_one :game, dependent: :destroy, validate: false do
    def extension
      "Testing"
    end
  end

  has_many :posts, dependent: :delete_all, validate: false do
    def extension
      "Testing"
    end
  end

  has_and_belongs_to_many :preferences, index: true, dependent: :nullify, validate: false
end
