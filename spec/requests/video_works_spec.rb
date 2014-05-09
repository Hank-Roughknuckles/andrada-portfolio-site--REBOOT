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
          fill_in "image link", with: "https://www.youtube.com/watch?v=0NbBjNiw4tk"
          fill_in "work", with: "google.com"
          click_button "Save"
          print page.html
        end

        it { should have_selector "#error_explanation", 
             text: "Header is too long" }
        it { should have_selector "#error_explanation", 
             text: "Description is too long" }
        it { should have_selector "#error_explanation", 
             text: "youtube" }
        it { should have_selector "#error_explanation", 
             text: "Tile image link is invalid" }
      end

      describe "editing with valid information" do
        let!(:new_collection) { "No Collection" }
        let!(:new_header) { "Brand New" }
        let!(:new_description) { "This is a new description" }
        let!(:new_work_link) { "http://vimeo.com/65696644" }
        let!(:new_tile_image_link) { 
          "http://i.vimeocdn.com/portrait/484340_300x300.jpg" 
        }

        before do
          select(new_collection, from: "video_work_folder_id")
          fill_in "Header", with: new_header
          fill_in "Description", with: new_description
          fill_in "work", with: new_work_link
          fill_in "image link", with: new_tile_image_link
          click_button "Save"
        end

        specify { expect(top_level_work.reload.folder_id).to eq ""}
        specify { expect(top_level_work.reload.header).to eq new_header}
        specify { expect(top_level_work.reload.description).to eq new_description}
        specify { expect(top_level_work.reload.work_link).to eq new_work_link}
        specify { expect(top_level_work.reload.tile_image_link).to eq new_tile_image_link}
      end
    end
  end
end
