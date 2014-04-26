class VideoWorksController < ApplicationController
  before_action :set_video_work, only: [:show, :edit, :update, :destroy]

  # GET /video_works
  # GET /video_works.json
  def index
    @video_works = VideoWork.all
  end

  # GET /video_works/1
  # GET /video_works/1.json
  def show
  end

  # GET /video_works/new
  def new
    @video_work = VideoWork.new
  end

  # GET /video_works/1/edit
  def edit
  end

  # POST /video_works
  # POST /video_works.json
  def create
    @video_work = VideoWork.new(video_work_params)

    respond_to do |format|
      if @video_work.save
        format.html { redirect_to @video_work, notice: 'Video work was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video_work }
      else
        format.html { render action: 'new' }
        format.json { render json: @video_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_works/1
  # PATCH/PUT /video_works/1.json
  def update
    respond_to do |format|
      if @video_work.update(video_work_params)
        format.html { redirect_to @video_work, notice: 'Video work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_works/1
  # DELETE /video_works/1.json
  def destroy
    @video_work.destroy
    respond_to do |format|
      format.html { redirect_to video_works_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_work
      @video_work = VideoWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_work_params
      params[:video_work]
    end
end
