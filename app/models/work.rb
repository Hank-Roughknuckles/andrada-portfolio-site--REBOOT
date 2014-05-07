class Work < ActiveRecord::Base

  IMAGE_LINK_REGEX = /\.(?:jpe?g|png|gif)(?:$|[?#])/

  validates :header,            presence: true,
                                length: { maximum: 50 }
  validates :tile_image_link,   presence: true,
                                format: { with: IMAGE_LINK_REGEX }
  validates :description,       length: { maximum: 400 }

end
