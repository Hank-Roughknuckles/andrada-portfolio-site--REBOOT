require 'spec_helper'

describe "video_works/new" do
  before(:each) do
    assign(:video_work, stub_model(VideoWork).as_new_record)
  end

  it "renders new video_work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", video_works_path, "post" do
    end
  end
end
