require 'spec_helper'

describe "LandingPage" do
  let!(:landing_page_photo) { FactoryGirl.create :landing_page_photo }
  let!(:user) { FactoryGirl.create :user }

  subject{ page }

  describe "showView" do

    describe "withoutLoggingIn" do
      before do
        logout :user
        visit root_path
      end

      it { should have_content "Sign In" }
      it { should_not have_content "Sign Out" }
    end

    describe "withLoggingIn" do
      before do
        login_as user
        visit root_path
      end
      it { should have_content "Sign Out" }
      it { should_not have_content "Sign In" }
    end

    describe "LandingPageContents" do
      before do
        visit root_path
        print page.html
      end

      it { should have_xpath "//img[@src='#{landing_page_photo.link}']" }
    end
  end
end
