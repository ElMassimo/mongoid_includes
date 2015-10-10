require 'spec_helper'

describe Mongoid::Criteria do
  Given(:criteria) { Band.includes(:songs, :owner, from: :albums) }
  Given(:other_criteria) { Band.includes(:musicians, :albums) }

  describe '#merge' do
    context 'inclusions are combined properly' do
      When(:new_criteria) { criteria.merge(other_criteria) }
      Then { new_criteria.inclusions.size == 4 }
      And  { new_criteria.inclusions.class == Mongoid::Includes::Inclusions }
      And  { criteria.inclusions.size == 3 }
      And  { other_criteria.inclusions.size == 2 }
    end
  end

  describe '#merge!' do
    context 'inclusions are merged properly' do
      When { criteria.merge!(other_criteria) }
      Then { criteria.inclusions.size == 4 }
      And  { criteria.inclusions.class == Mongoid::Includes::Inclusions }
      And  { other_criteria.inclusions.size == 2 }
    end
  end
end
