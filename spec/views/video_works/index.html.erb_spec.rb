require 'spec_helper'

describe "video_works/index" do
  before(:each) do
    assign(:video_works, [
      stub_model(VideoWork),
      stub_model(VideoWork)
    ])
  end

  it "renders a list of video_works" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
