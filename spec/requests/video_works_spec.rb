require 'spec_helper'

describe "VideoWorks" do
  describe "GET /video_works" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get video_works_path
      response.status.should be(200)
    end
  end
end