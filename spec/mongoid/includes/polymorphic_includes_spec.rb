require 'spec_helper'

describe Mongoid::Includes::Criteria do

  describe '#includes' do
    Given(:inclusions) { criteria.inclusions }

    context 'multiple inclusions through polymorphic associations' do
      Given(:pink_floyd) { Band.create!(name: 'Pink Floyd', musician_ids: [nil, '']) }
      Given(:jethro) { Band.create!(name: 'Jethro Tull') }
      Given {
        Artist.create!(name: 'David Gilmour', associated_act: pink_floyd)
        wywh = Album.create!(name: 'Wish You Were Here', release: Date.new(1975), owner: pink_floyd)
        Album.create!(name: 'The Dark Side of the Moon', release: Date.new(1973), owner: pink_floyd)

        Artist.create!(name: 'Ian Anderson', associated_act: jethro)
        standup = Album.create!(name: 'Stand Up', release: Date.new(1969), owner: jethro)
        Album.create!(name: 'Aqualung', release: Date.new(1971), owner: jethro)

        Song.create!(name: 'Shine On', album: wywh)
        Song.create!(name: 'We Used to Know', album: standup)
      }
      Given(:criteria) {
        Artist
          .includes(:musicians, from: :associated_act, from_class: Band)
          .includes(:associated_act, with: ->(bands) {
            bands
              .includes(:albums, with: ->(albums) { albums.gt(release: 1970) })
              .includes(:songs, from: :albums, with: ->(songs) { songs })
          })
      }

      describe ':with inclusions should not be overriden', skip: ENV["CI"] do
        When(:artists) { expect_query(4) { criteria.entries } } # There are no musicians, so no query should be made.
        Given(:albums) { artists.map(&:associated_act).flat_map(&:albums) }
        Then { artists.size == 2 }
        And {
          expect_no_queries { albums.size == 3 } # gt(release: 1970)
        }
        And {
          expect_no_queries { albums.flat_map(&:songs).size == 1 } # Only "Shine On"
        }
      end

      describe 'should not replace an includes with an specified modifier with a generic one' do
        Given(:inclusions) { new_criteria.inclusions.to_a }
        When(:new_criteria) { criteria.includes(:musicians, from: :associated_act, from_class: Band) }
        Then { inclusions.size == 2 }
        And  { inclusions.first.nested? }
        And  { inclusions.last.polymorphic? && inclusions.last.modifier }
      end

      it 'should fail if a polymorphic association is not disambiguated' do
        expect {
          criteria.includes(:musicians, from: :associated_act)
        }.to raise_error(Mongoid::Includes::Errors::InvalidPolymorphicIncludes)
      end
    end
  end
end
