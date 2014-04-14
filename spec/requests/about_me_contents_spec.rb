require 'spec_helper'

def add_content
  visit edit_about_me_content_path about_me_content.id

  fill_in "Header", with: "Test Header"
  fill_in "Description", with: "Test Description"
  fill_in "Button Title", with: "Test Button Title"

  click_button "save_button_top"
end

describe "AboutMePages" do

  let(:about_me_content) { FactoryGirl.create :about_me_content }
  let(:user) { FactoryGirl.create :user }

  subject{ page }

  describe "Index page" do
    before do
      login_as user
      add_content
      visit root_path
    end

    it { should have_title "About Me" }
    it { should have_content "Edit" }
  end

  describe "Edit pages" do
    before do
      login_as user
      visit edit_about_me_content_path about_me_content.id
    end

    describe "Edit page contents" do
      it { should have_title "Edit" }
      it { should have_content "image" }
      it { should have_field "about_me_content[header]" }
      it { should have_field "about_me_content[description]" }
      it { should have_field "about_me_content[button_title]" }
      it { should have_link "Sign Out" }
      it { should_not have_link "Sign In" }

      it { should have_xpath "//input[@value=\"#{about_me_content.header}\"]" }
      it { should have_content about_me_content.description }
      it { should have_xpath "//input[@value=\"#{about_me_content.button_title}\"]" }
    end

    describe "Updating the text on a slide" do
      before do
        fill_in "Header", with: "Test Header"
        fill_in "Description", with: "Test Description"
        fill_in "Button Title", with: "Test Button Title"

        click_button "save_button_top"
      end

      it { should have_content "Test Header" }
      it { should have_content "Test Description" }
      it { should have_content "Test Button Title" }
    end
  end
end
