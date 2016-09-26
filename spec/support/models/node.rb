class Node
  include Mongoid::Document

  has_and_belongs_to_many :parents, class_name: 'Node', inverse_of: :children
  has_and_belongs_to_many :children, class_name: 'Node', inverse_of: :parents
end
