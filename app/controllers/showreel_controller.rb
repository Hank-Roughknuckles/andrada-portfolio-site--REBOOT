class ShowreelController < ApplicationController
  before_filter :authorize, :except => :show

  def show
    @content = Showreel.find params[:id]
  end

  def edit
    @content = Showreel.find params[:id]
  end

  def update
    @content = Showreel.find(params[:id])
    if @content.update_attributes showreel_params
      redirect_to action: "show"
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
        on Vimeo"
      render 'edit'
    end
  end

  def showreel_params
    params.require(:showreel).permit(:header, :description, :media_link, :media_choice, :media_image, :background_image)
  end
end
