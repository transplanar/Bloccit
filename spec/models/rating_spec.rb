require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating){Rating.create!(severity: :PG)}

  describe "initialize attributes" do
    it "should assign severity" do
      expects(:rating.severity).to eq(:PG)
    end

    it "should only assign valid ratings" do
      :rating.update_rating(:PG13)

      expects(:rating.severity).to eq(:PG13)
    end
  end
end
