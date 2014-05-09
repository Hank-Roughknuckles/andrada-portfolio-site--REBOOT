class Work < ActiveRecord::Base

  IMAGE_LINK_REGEX = /\.(?:jpe?g|png|gif)(?:$|[?#])/
  VIMEO_LINK_REGEX = /^(https?:\/\/)?(www.)?vimeo.com\/[a-zA-Z0-9\-=\?]+/
  YOUTUBE_LINK_REGEX = 
    /^(https?:\/\/)?(www.)?youtube.com\/watch\?v\=[a-zA-Z0-9\-=\?]+/


  before_validation :strip_whitespace

  validate  :work_link_must_be_media
  validates :header,            presence: true,
                                length: { maximum: 50 }
  validates :tile_image_link,   presence: true,
                                format: { with: IMAGE_LINK_REGEX }
  validates :description,       length: { maximum: 400 }
  validates :work_link,         presence: true


  ########################################################################
  #
  # Methods
  #
  ########################################################################
  def work_link_must_be_media
    if work_link.present? && (!work_link.match(YOUTUBE_LINK_REGEX) && 
                              !work_link.match(VIMEO_LINK_REGEX) && 
                              !work_link.match(IMAGE_LINK_REGEX))
      errors.add(:work_link, "must be a youtube, vimeo or image link")
    end
  end


  def strip_whitespace
    if tile_image_link.present?
      tile_image_link.strip!
    end

    if work_link.present?
      work_link.strip!
    end
  end
end
