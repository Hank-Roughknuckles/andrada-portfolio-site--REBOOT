class WorksController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = Work.all
  end

  def edit
    @contents = Work.all
    @content = Work.find params[:id]
    @position = GridPosition.find_by(parent_name: "works")
  end

  def new
    @contents = Work.all
    @content = Work.new( media_link: "https://vimeo.com/14470340", media_choice: "link", grid_row: 1, grid_column: 1, grid_sizex: 1, grid_sizey: 1 )
    @position = GridPosition.find_by(parent_name: "works")
  end

  def create
    @contents = Work.all
    @content = Work.new(works_params)

    if @content.save
      @content.reprocess_grid_tile_image if @content.cropping?
      @position = GridPosition.find_by(parent_name: "works")
      if params[:work][:grid_tile_image].blank?
        flash[:notice] = "New Work Added"
        save_grid_position( caller: "works" )
        redirect_to action: "index"
      else
        save_grid_position( caller: "works" )
        render "shared/crop"
      end
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'new'
    end
  end

  def update
    @contents = Work.all
    @content = Work.find(params[:id])
    @position = GridPosition.find_by(parent_name: "works")

    if @content.update_attributes works_params
      @content.reprocess_grid_tile_image if @content.cropping?
      if params[:work][:grid_tile_image].blank?
        save_grid_position( caller: "works" )
        redirect_to action: "index"
      else
        save_grid_position( caller: "works" )
        render "shared/crop"
      end
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def destroy
    if @content = Work.find(params[:id])
      @content.destroy
      redirect_to action: "index"
      flash[:notice] = "Work Was Deleted Successfully"
    else
      flash[:error] = "An error occurred, please contact the
      web-programmer"
    end
  end

  def works_params
    params.require(:work).permit(:header, :description, :media_link,
                                 :media_choice, :media_image,
                                 :background_image, :grid_row,
                                 :grid_column, :grid_sizex, :grid_sizey,
                                 :grid_tile_image, :crop_x, :crop_y,
                                 :crop_h, :crop_w )
  end
end
