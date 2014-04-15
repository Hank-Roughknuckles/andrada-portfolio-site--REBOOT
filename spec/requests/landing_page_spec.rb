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
      it { should_not have_content "Sign In" }
    end

    describe "page contents" do
      before do
        visit root_path
        print page.html
      end

      it { should have_title "Andrada Popan-Dorca" }

      it { should have_link "About Me" }
      it { should have_link "Video" }
      it { should have_link "Photo" }
      it { should have_link "Current Projects" }
      it { should have_link "Contact" }

      it { should have_xpath "//img[@src='#{landing_page_photo.link}']" }
    end

    describe "links in the page" do
      it "points to the proper page"
    end
  end
end
