class GridPositionsController < ApplicationController
  def update
    @position = GridPosition.find(params[:id])
    respond_to do |format|
      if @position.update_attributes grid_positions_params
        format.json {render json: @position}
      else
        format.json { 
          render json: @position.errors, status: :unprocessable_entity 
        }
      end
    end
  end

  def grid_positions_params
    params.require(:grid_position).permit(:id, :parent_name, :serialized_array)
  end
end
