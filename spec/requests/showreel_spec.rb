require 'spec_helper'

describe "ShowreelPages" do
  let(:showreel) { FactoryGirl.create :showreel }
  let(:user) { FactoryGirl.create :user }
  subject { page }

  before do
    visit showreel_path showreel.id
  end

  describe "Showreel nav button" do
    before do
      visit root_path
      click_link "Showreel"
    end

    it { should have_title "Showreel" }
  end
  
  describe "Show page" do
    describe "Show page contents" do
      before do
        visit showreel_path showreel.id
      end

      it { should have_title "Showreel" }
      it { should have_content showreel.header }
      it { should have_content showreel.description }

      describe "The Edit Button" do
        describe "when not logged in" do
          it { should_not have_content "Edit Content" }
        end

        describe "when logged in" do
          before do
            login_as user
            visit showreel_path showreel.id
          end
          it { should have_content "Edit Content" }
        end
      end
    end
  end

  describe "Edit page" do
    before do
      login_as user
      visit showreel_path showreel.id
    end

    describe "The link to the edit page" do
      it { should have_link "Edit Content" }
    end

    describe "The edit page" do
      before do
        visit showreel_path showreel.id
        click_link "Edit Content"
      end

      describe "Edit page contents" do
        it { should have_field "Header" }
        it { should have_field "Description" }
        it { should have_field "Media link" }
        it { should have_field "showreel_media_choice_link" }
        it { should have_field "showreel_media_choice_upload" }
      end

      describe "The Edit process" do
        describe "Editing the header and description" do
          before do
            fill_in "Header", with: "test Header"
            fill_in "Description", with: "test Description"
            click_button "Save"
          end

          it { should have_content "test Header" }
          it { should have_content "test Description" }
        end

        describe "Changing the video" do
          describe "By adding an improper link" do
            before do
              fill_in "Media link", with: "www.google.com/1234"   
              click_button "Save"
            end

            it { should have_content "Invalid video link" }
          end

          describe "By adding a proper link" do
            before do
              fill_in "Media link", with: "  https://vimeo.com/63967638  "   
              click_button "Save"
            end

            it { should_not have_content "Invalid video link" }
          end
        end
      end
    end
  end
end
