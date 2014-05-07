require 'spec_helper'

describe VideoWork do
  it "has a valid factory" do
    FactoryGirl.create(:video_work).should be_valid
  end

  it "is invalid without a header" do
    FactoryGirl.build(:video_work, header: nil).should_not be_valid
  end

  it "only accepts valid links" do
    FactoryGirl.build(:video_work, tile_image_link: "www.google.com").should_not be_valid
  end
  
end
