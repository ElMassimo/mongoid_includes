class Game
  include Mongoid::Document

  field :high_score, type: Integer, default: 500
  field :score, type: Integer, default: 0
  field :name

  belongs_to :person, index: true, validate: true

  if Mongoid::VERSION >= "6.0.0"
    belongs_to :parent, class_name: "Game", foreign_key: "parent-id", optional: true
  else
    belongs_to :parent, class_name: "Game", foreign_key: "parent-id"
  end

  accepts_nested_attributes_for :person

  validates_format_of :name, without: /\$\$\$/

  set_callback(:initialize, :after) do |document|
    write_attribute("name", "Testing") unless name
  end
end
