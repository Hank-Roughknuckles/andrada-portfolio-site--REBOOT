class LandingPagesController < ApplicationController
  layout "landing_page_layout"
  before_action :set_photo, except: :update

  before_filter :authorize, except: :show
  helper_method :get_slide_background_css

  def show
  end

  def edit
  end

  def update
    @landing_page_photo = LandingPagePhoto.find(params[:id])
    if @landing_page_photo.update landing_page_params
      flash[:notice] = "Updated"
      redirect_to action: "show"
    else
      flash[:alert] = "Invalid link type"
      redirect_to edit_landing_page_path
    end
  end

private
  def set_photo
    @landing_page_photo = LandingPagePhoto.first
  end

  def landing_page_params
    params.require(:landing_page_photo).permit(:link)
  end
end
