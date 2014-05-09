class Collection < ActiveRecord::Base
  has_ancestry

  IMAGE_LINK_REGEX = /\.(?:jpe?g|png|gif)(?:$|[?#])/
  before_validation :strip_whitespace

  validates :name,              presence: true,
                                length: { maximum: 50 }
  validates :tile_image_link,   presence: true,
                                format: { with: IMAGE_LINK_REGEX }

  ########################################################################
  #
  # Methods
  #
  ########################################################################
  def strip_whitespace
    tile_image_link.strip!
  end
end
