class LandingPagesController < ApplicationController
  layout "landing_page_layout"
  before_action :get_photo

  before_filter :authorize, :except => :show
  helper_method :get_slide_background_css

  def show
  end

  def edit
  end

private
  def get_photo
    @landing_page_photo = LandingPagePhoto.first
  end
end
