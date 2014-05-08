require 'spec_helper'

describe "VideoWorks" do

  subject{ page }

  FactoryGirl.create(:landing_page_photo)

  let!(:user) { FactoryGirl.create(:user) }

  let!(:parent_collection) do 
    FactoryGirl.create(:video_collection, name: "Parent Collection") 
  end
  let!(:child_collection) do 
    FactoryGirl.create(:video_collection, parent: parent_collection, 
                                          name: "Child Collection") 
  end
  let!(:top_level_work) do 
    FactoryGirl.create(:video_work, folder_id: nil)
  end
  let!(:work_in_parent_collection) do 
    FactoryGirl.create(:video_work, folder_id: parent_collection.id) 
  end
  let!(:work_in_child_collection) do 
    FactoryGirl.create(:video_work, folder_id: child_collection.id) 
  end

  let!(:invalid_login_message) { "Please log in" }

  ########################################################################
  #
  # The Edit action
  #
  ########################################################################
  describe "The edit action" do
    describe "while logged out" do
      before do
        logout user
        visit edit_video_work_path top_level_work
      end

      it { should have_content invalid_login_message }
    end

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Editing while logged in
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    describe "while logged in" do
      before do
        login_as user
        visit edit_video_work_path top_level_work
      end

      it { should have_field "Parent Collection" }
      it { should have_field "Header" }
      it { should have_field "Description" }
      it { should have_field "Link" } #link to the work
      it { should have_content "Reload" }
      it { should have_field "image" } #link for the grid image

      describe "editing with invalid information" do
        before do
          fill_in "Header", with: "a" * 51
          fill_in "Description", with: "a" * 401
          click_button "Save"
        end

        it { should have_selector "#error_explanation", 
             text: "Header is too long" }
        it { should have_selector "#error_explanation", 
             text: "Description is too long" }
      end
    end
  end

end
