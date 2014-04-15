require 'spec_helper'

describe LandingPagePhoto do
  it "has a valid factory" do
    FactoryGirl.create(:landing_page_photo).should be_valid
  end

  it "is invalid without a link" do
    FactoryGirl.build(:landing_page_photo, link: nil).should_not be_valid
  end
end
