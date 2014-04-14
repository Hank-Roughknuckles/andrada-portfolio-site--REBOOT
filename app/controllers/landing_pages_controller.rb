class LandingPagesController < ApplicationController
  def show
    @landing_page_photo = LandingPagePhoto.first
  end
end
