require 'spec_helper'

describe "LandingPage" do
  let!(:landing_page_photo) { FactoryGirl.create :landing_page_photo }
  let!(:user) { FactoryGirl.create :user }

  subject{ page }

  describe "the 'show' view" do

    describe "without logging in" do
      before do
        logout :user
        visit root_path
      end

      it { should have_content "Sign In" }
      it { should_not have_content "Sign Out" }
    end

    describe "with logging in" do
      before do
        login_as user
        visit root_path
      end
      it { should have_content "Sign Out" }
      it { should have_content "Edit" }
      it { should_not have_content "Sign In" }
    end

    describe "page contents" do
      before do
        visit root_path
      end

      it { should have_title "Andrada Popan-Dorca" }

      it { should have_link "About Me" }
      it { should have_link "Video" }
      it { should have_link "Photo" }
      it { should have_link "Current Projects" }
      it { should have_link "Contact" }

      it { should have_css ".bg-img" }
    end
  end

  describe "The Edit view" do
    describe "should not show if not logged in" do
      before do
        logout user
        visit edit_landing_page_path(landing_page_photo)
      end

      it { should have_content "Unauthorized" }
    end

    describe "Page" do
      before do
        login_as user
        visit root_path
        click_link "Edit"
      end

      describe "contents" do
        it { should have_title "Edit" }
        it { should have_field "Link" }
        it { should have_button "Save" }
      end

      describe "saving a new link" do
        describe "with a valid link" do
          let!(:new_link) { "http://www.digitaltrends.com/wp-content/uploads/2013/04/Samsung-Galaxy-6-3-sample-image-3.jpg" }
          before do
            fill_in "Link", with: new_link
            click_button "Save"
          end

          it { should have_xpath "//img[@class='bg-img' and @src='#{new_link}']" }
        end

        describe "with an invalid link" do
          let!(:new_link) { "google.com" }
          before do
            fill_in "Link", with: new_link
            click_button "Save"
          end

          it { should_not have_xpath "//img[@class='bg-img' and @src='#{new_link}']" }
          it { should have_content "Invalid" }

        end
      end
    end
  end
end
