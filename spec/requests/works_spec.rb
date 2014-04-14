require 'spec_helper'

describe "WorksPages" do
  let!(:user) { FactoryGirl.create :user }
  let!(:works1) { FactoryGirl.create :work }
  let!(:works2) { FactoryGirl.create :work }

  subject { page }

  describe "The index page" do
    describe "The page layout" do
      describe "when not signed in" do
        before do
          logout :user
          visit works_path
        end

        it { should have_content "Sign In" }
      end

      describe "when signed in" do
        before do
          login_as user
          visit works_path
        end

        it { should have_content "Sign Out" }
      end
    end
  end

  describe "The Edit Page" do
    before do
      login_as user
      visit works_path
      click_link "edit_work_#{works1.id}"
    end

    describe "Edit page layout" do
      it { should have_content works1.header }
      it { should have_content works1.description }
      it { should have_xpath "//iframe" }

      it { should have_field "Media link" }
      it { should have_field "Header" }
      it { should have_field "Description" }
    end

    describe "The Editing Process" do
      describe "With an invalid video link" do
        before do
          fill_in "Media link", with: "www.google.com"
          click_button "save_button_bottom"
        end

        it { should have_content "Invalid video link" }
      end

      describe "With a valid video link" do
        before do
          fill_in "Media link", with: "https://vimeo.com/83571847"
          fill_in "Header", with: "Test Header"
          fill_in "Description", with: "Test Description"
          click_button "Save"
        end

        it { should have_content "Test Header" }
        it { should have_content "Test Description" }
        it { should have_xpath "//iframe" }
      end
    end
  end

  describe "The New Page" do
    before do
      login_as user
      visit works_path
      click_link "Add New Item"
    end
    
    it { should have_content "Add New Work" }
    it { should have_title "New Work" }
    it { should have_field "Media link" }
    it { should have_field "work_media_choice_link" }
    it { should have_field "work_media_choice_upload" }
    it { should have_field "Header" }
    it { should have_field "Description" }
    it { should have_xpath "//iframe" }

    describe "Adding a new work" do
      describe "with an invalid video link" do
        before do
          fill_in "Media link", with: "www.google.com"
          click_button "Save"
        end

        it { should have_content "Invalid video link" }
      end

      describe "with a valid video link" do
        before do
          fill_in "Media link", with: "https://vimeo.com/83571847"
          fill_in "Header", with: "Test Header"
          fill_in "Description", with: "Test Description"
          click_button "Save"
        end

        it { should have_content "Test Header" }
        it { should have_content "Test Description" }
        it { should have_content "New Work Added" }
        it { should have_xpath "//iframe" }
      end
    end
  end

  describe "The Destroy Process" do
    before do
      login_as user
      visit works_path
      click_button "delete_work_#{works1.id}"
    end

    it { should have_content "Deleted Successfully" }
    it { should_not have_content works1.header }
    it { should_not have_content works1.description }
  end
end
