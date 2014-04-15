class LandingPagesController < ApplicationController
  layout "landing_page_layout"

  def show
    @landing_page_photo = LandingPagePhoto.first
  end
end
