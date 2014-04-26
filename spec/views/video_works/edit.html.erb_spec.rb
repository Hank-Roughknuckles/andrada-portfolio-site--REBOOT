require 'spec_helper'

describe "video_works/edit" do
  before(:each) do
    @video_work = assign(:video_work, stub_model(VideoWork))
  end

  it "renders the edit video_work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", video_work_path(@video_work), "post" do
    end
  end
end
