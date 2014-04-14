class Work < ActiveRecord::Base

  validates_presence_of :media_choice
  before_validation :strip_whitespace
  has_attached_file :media_image, 
    :default_url => "/assets/placeholder.png"  
  has_attached_file :grid_tile_image, 
    :styles => { :small => "100x100#", :large => "500x500>" }, 
    :processors => [:cropper],
    :default_url => "/assets/placeholder.png"

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h 

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_h.blank? && !crop_w.blank?
  end

  def grid_tile_image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(
      grid_tile_image.path(style))
  end

  def reprocess_grid_tile_image
    grid_tile_image.reprocess!
  end

  private
  def strip_whitespace
    self.media_link = self.media_link.strip
  end
end
