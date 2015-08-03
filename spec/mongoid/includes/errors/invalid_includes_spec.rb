require 'spec_helper'
require './spec/support/models/album'

describe Mongoid::Includes::Errors::InvalidIncludes do

  describe "#message" do

    Given(:error) {
      described_class.new(Album, :musicians, from: :artist)
    }

    it "contains the problem in the message" do
      expect(error.message).to include(
        "Eager loading :ratable is not supported since it is a polymorphic"
      )
    end

    it "contains the summary in the message" do
      expect(error.message).to include(
        "Mongoid cannot currently determine the classes it needs to eager"
      )
    end

    it "contains the resolution in the message" do
      expect(error.message).to include(
        "Don't attempt to perform this action and have patience"
      )
    end
  end
end
