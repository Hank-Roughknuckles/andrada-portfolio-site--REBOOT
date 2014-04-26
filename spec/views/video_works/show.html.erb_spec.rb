require 'spec_helper'

describe "video_works/show" do
  before(:each) do
    @video_work = assign(:video_work, stub_model(VideoWork))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
