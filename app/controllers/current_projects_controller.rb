class CurrentProjectsController < ApplicationController
  before_filter :authorize, :except => :index

  def index
    @contents = CurrentProject.all
  end

  def new
    @contents = CurrentProject.all
    @content = CurrentProject.new( 
      media_link: "https://vimeo.com/14470340", 
      progress: 50, 
      media_choice: "link", 
      grid_row: 1, 
      grid_column: 1, 
      grid_sizex: 1, 
      grid_sizey: 1 )
    @position = GridPosition.find_by(parent_name: "current_projects")
  end

  def create
    @contents = CurrentProject.all
    @content = CurrentProject.new( current_project_params )

    if @content.save
      @content.reprocess_grid_tile_image if @content.cropping?
      @position = GridPosition.find_by(parent_name: "current_projects")
      if params[:current_project][:grid_tile_image].blank?
        flash[:notice] = "New Project Added"
        save_grid_position( caller: "current_projects" )
        redirect_to action: "index"
      else
        save_grid_position( caller: "current_projects" )
        render "shared/crop"
      end
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'new'
    end
  end

  def edit
    @contents = CurrentProject.all
    @content = CurrentProject.find params[:id]
    @position = GridPosition.find_by(parent_name: "current_projects")
  end

  def update
    @contents = CurrentProject.all
    @content = CurrentProject.find(params[:id])
    @position = GridPosition.find_by(parent_name: "current_projects")

    if @content.update_attributes current_project_params
      @content.reprocess_grid_tile_image if @content.cropping?
      if params[:current_project][:grid_tile_image].blank?
        save_grid_position( caller: "current_projects" )
        redirect_to action: "index"
      else
        save_grid_position( caller: "current_projects" )
        render "shared/crop"
      end
    else
      flash[:alert] = "Invalid video link.  Please use a link to a video
      on Vimeo or Youtube"
      render 'edit'
    end
  end

  def destroy
    if (@content = CurrentProject.find params[:id])
      @content.destroy
      redirect_to action: "index"
      flash[:notice] = "Project successfully deleted"
    else
      flash[:error] = "An error occurred, please contact the
      web-programmer"
    end
  end

  def current_project_params
    params.require(:current_project).permit(:header, :description,
                                            :media_link, :progress,
                                            :media_choice, :media_image,
                                            :grid_row, :grid_column,
                                            :grid_sizex, :grid_sizey,
                                            :grid_tile_image, :crop_x,
                                            :crop_y, :crop_h, :crop_w )
  end
end
