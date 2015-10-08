require 'spec_helper'

describe Mongoid::Includes::Inclusions do

  describe '#inclusions' do
    Given(:criteria) { Band.includes(:songs, :owner, from: :albums) }
    Given(:inclusions) { criteria.inclusions }

    context 'adding two different inclusions' do
      Given(:other_criteria) { Band.includes(:musicians, :albums) }
      When(:result) { inclusions + other_criteria.inclusions }
      Then { result.size == 4 }
      And  { result.class == Mongoid::Includes::Inclusions }
    end

    context 'when removing duplicates' do
      Given(:inclusions) { Mongoid::Includes::Inclusions.new(criteria.inclusions) }
      When(:result) { inclusions.uniq }
      Then { result.size == 3 }
      And  { result.class == Mongoid::Includes::Inclusions }
    end
  end
end
