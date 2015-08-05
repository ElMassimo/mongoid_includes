require 'spec_helper'

describe Mongoid::Includes::Errors::InvalidPolymorphicIncludes do

  describe "#message" do

    Given(:error) {
      described_class.new(Album, :something, from: :artist)
    }

    it "contains the problem in the message" do
      expect(error.message).to include(
        ":artist is a polymorphic relation"
      )
    end

    it "contains the summary in the message" do
      expect(error.message).to include(
        "specify :from_class when calling the method to resolve the ambiguity"
      )
    end

    it "contains the resolution in the message" do
      expect(error.message).to include(
        "non-polymorphic relation in the Album model, or a explicit class in :from_class"
      )
    end
  end
end
