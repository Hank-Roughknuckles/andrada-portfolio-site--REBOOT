require 'spec_helper'

describe "CurrentProjectsPages" do
  let!(:current_project_1) { FactoryGirl.create :current_project }
  let!(:current_project_2) { FactoryGirl.create :current_project }
  let!(:user) { FactoryGirl.create :user }

  subject { page }

  describe "Index page" do
    before do
      visit root_path
      click_link "Current Projects"
    end

    it { should have_title "Current Projects" }

    describe "when not logged in" do
      it { should_not have_content "Edit Content" }
    end

    describe "when logged in" do
      before do
        login_as user
        visit current_projects_path
      end
      it { should have_xpath "//table//td/a[text()=\"Edit\"]" }
      it { should have_content "Add" }
      it { should have_button "Delete" }

      describe "The Edit Page" do
        before do
          click_link "edit_current_project_#{current_project_1.id}"
        end

        it { should have_field "Header" }
        it { should have_field "Description" }
        it { should have_field "Media link" }
        it { should have_field "media_image_upload" }
        it { should have_field "current_project_media_choice_link" }
        it { should have_field "current_project_media_choice_upload" }
        it { should have_field "Progress" }

        describe "the Edit Process" do
          describe "With invalid information" do
            before do
              fill_in "Media link", with: "youtube.com"
              choose "Use Hosted Link"
              click_button "Save"
            end

            it { should have_content "Invalid video link" }
          end

          describe "With valid information" do
            before do
              fill_in "Header", with: "test Header 1"
              fill_in "Description", with: "test Description 1"
              fill_in "Media link", with: "http://www.youtube.com/watch?annotation_id=annotation_644039&feature=iv&src_vid=TJSGda3b3wA&v=eiMGJBxRtBw"
              choose "Use Hosted Link"
              fill_in "Progress", with: 35
              click_button "Save"
            end

            it { should have_content "updated successfully" }
          end
        end
      end

      describe "The Add Page" do
        before do
          click_link "Add"
        end

        it { should have_field "Header" }
        it { should have_field "Description" }
        it { should have_field "Media link" }
        it { should have_field "Progress" }

        describe "The add process" do
          before do
            fill_in "Header", with: "test Header 1"
            fill_in "Description", with: "test Description 1"
            fill_in "Media link", with: "http://www.youtube.com/watch?annotation_id=annotation_644039&feature=iv&src_vid=TJSGda3b3wA&v=eiMGJBxRtBw"
            fill_in "Progress", with: 35
            click_button "Save"
          end
          
          it { should have_content "saved successfully" }
        end
      end

      describe "The Delete Process" do
        before do
          click_button "delete_work_#{current_project_1.id}"
        end

        it { should_not have_content current_project_1.header }
        it { should_not have_content current_project_1.description }
        it { should have_content "successfully deleted" }
      end
    end
  end
end
