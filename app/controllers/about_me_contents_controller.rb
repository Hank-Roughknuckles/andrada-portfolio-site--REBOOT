class AboutMeContentsController < ApplicationController
  before_filter :authorize, :except => :index
  helper_method :get_slide_background_css

  def index
    @count = AboutMeContent.count
    @contents = AboutMeContent.all
    @active_content_id = 0
  end

  def admin_index
    @contents = AboutMeContent.all
  end

  def edit
    @content = AboutMeContent.find(params[:id])
    @active_content_id = @content.id
    @count = AboutMeContent.count
    @is_preview = true
  end

  def update
    @content = AboutMeContent.find(params[:id])
    if @content.update_attributes! content_params
      @contents = AboutMeContent.all
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def content_params
    params.require(:about_me_content).permit(:background_image, :header, :description, :button_title)
  end
end
