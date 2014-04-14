require 'spec_helper.rb'

describe "SignInPages" do

  before { visit new_user_session_path }
  subject {page}
  let(:user) { FactoryGirl.create :user }

  describe "the sign-in page contents" do
    it { should have_title "Sign in" }
    it { should have_content "Email" }
    it { should have_content "Password" }
    it { should have_content "Remember me" }
    it { should have_button "Sign in" }
  end

  describe "the sign-in process" do

    describe "with valid info" do
      before do
        fill_in "Email",     with: user.email
        fill_in "Password",  with: user.password
        click_button "Sign in"
      end
      it { should have_content("success") }
    end

    describe "with invalid info" do 
      before do
        fill_in "Email",    with: "wrong"
        fill_in "Password", with: "wrong"
        click_button "Sign in"
      end
      it { should have_content("Invalid") }
    end
  end
  
  describe "The sign-out process" do
    subject { page }
    let(:user) { FactoryGirl.create :user }

    before do
      login_as user
      visit root_path
      click_link "Sign Out"
    end
    it { should have_content "Signed out" }
  end
end
